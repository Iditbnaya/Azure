import os
import csv
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import SubscriptionClient
from azure.mgmt.authorization import AuthorizationManagementClient
from azure.graphrbac import GraphRbacManagementClient
from tabulate import tabulate

def get_tenant_id(subscription_client):
    """Automatically fetch the tenant ID."""
    try:
        # Use the tenants method to fetch tenant information
        tenants = subscription_client.tenants.list()
        for tenant in tenants:
            print(f"Found Tenant ID: {tenant.tenant_id}")  # Debug information
            return tenant.tenant_id  # Return the first tenant ID
        print("No tenants found.")
    except Exception as e:
        print(f"Error fetching tenant ID: {e}")
    return None

def main():
    # Authenticate using DefaultAzureCredential
    credential = DefaultAzureCredential()
    subscription_client = SubscriptionClient(credential)

    # Automatically fetch the tenant ID
    tenant_id = get_tenant_id(subscription_client)
    if not tenant_id:
        raise ValueError("Unable to fetch tenant ID. Ensure your account has the necessary permissions.")

    # Azure AD client for group member resolution
    graph_client = GraphRbacManagementClient(credential, tenant_id)

    # Initialize counters
    total_subscriptions = 0
    disabled_subscriptions = 0
    single_owner_subscriptions = 0

    # Table data
    table_data = []

    print("Fetching subscription details...")

    # Iterate over all subscriptions
    for subscription in subscription_client.subscriptions.list():
        total_subscriptions += 1

        subscription_id = subscription.subscription_id
        subscription_name = subscription.display_name
        subscription_state = subscription.state
        
        # Determine if subscription is disabled
        is_disabled = subscription_state == "Disabled"
        if is_disabled:
            disabled_subscriptions += 1

        # Get the list of unique user owners for the subscription
        owner_count, inheritance_status = get_owner_count_and_inheritance(
            subscription_id, credential, graph_client
        )
        
        if owner_count == 1:
            single_owner_subscriptions += 1

        # Add to table data
        table_data.append([
            subscription_name,
            subscription_id,
            owner_count,
            "Yes" if is_disabled else "No",
            inheritance_status
        ])

    # Print summary
    print("Summary:")
    print(f"Total Subscriptions: {total_subscriptions}")
    print(f"Disabled Subscriptions: {disabled_subscriptions}")
    print(f"Subscriptions with One Owner: {single_owner_subscriptions}")

    # Print table
    print("\nSubscription Details:")
    print(tabulate(
        table_data,
        headers=["Subscription Name", "Subscription ID", "Owner Count", "Is Disabled", "Inheritance"],
        tablefmt="grid"
    ))

    # Export to CSV
    export_to_csv(table_data)

def get_owner_count_and_inheritance(subscription_id, credential, graph_client):
    from azure.mgmt.authorization import AuthorizationManagementClient

    # Create an authorization client for the subscription
    auth_client = AuthorizationManagementClient(credential, subscription_id)

    # Get role definitions for "Owner" to match role definition IDs
    owner_role_id = None
    try:
        for role_definition in auth_client.role_definitions.list(
            scope=f"/subscriptions/{subscription_id}", 
            filter="roleName eq 'Owner'"
        ):
            owner_role_id = role_definition.id
            break
    except Exception as e:
        print(f"Error fetching role definitions for subscription {subscription_id}: {e}")
        return 0, "Unknown"

    if not owner_role_id:
        return 0, "Unknown"

    # Identify unique user owners and determine inheritance status
    unique_owners = set()
    inheritance_status = "Direct"

    try:
        for role_assignment in auth_client.role_assignments.list_for_scope(
            scope=f"/subscriptions/{subscription_id}"
        ):
            # Check if the role assignment matches the owner role
            if role_assignment.role_definition_id.endswith(owner_role_id):
                principal_type = role_assignment.principal_type
                principal_id = role_assignment.principal_id

                # Check if the assignment is inherited
                if role_assignment.scope != f"/subscriptions/{subscription_id}":
                    inheritance_status = "Inherited"

                # Handle user, group, service principal, or other
                if principal_type == "User":
                    unique_owners.add(principal_id)
                elif principal_type == "Group":
                    unique_owners.update(resolve_group_members(principal_id, graph_client))
                # Ignore Service Principals and Managed Identities
                elif principal_type not in ["ServicePrincipal", "ManagedIdentity"]:
                    unique_owners.add(principal_id)
    except Exception as e:
        print(f"Error fetching role assignments for subscription {subscription_id}: {e}")

    return len(unique_owners), inheritance_status

def resolve_group_members(group_id, graph_client):
    """Resolve members of an Azure AD group."""
    members = set()
    try:
        for member in graph_client.groups.get_group_members(group_id):
            # Add only user members (ignore nested groups or other types)
            if member.object_type == "User":
                members.add(member.object_id)
    except Exception as e:
        print(f"Error resolving members of group {group_id}: {e}")
    return members

def export_to_csv(data):
    """Export data to a CSV file."""
    with open("subscription_details.csv", mode="w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        # Write headers
        writer.writerow(["Subscription Name", "Subscription ID", "Owner Count", "Is Disabled", "Inheritance"])
        # Write data
        writer.writerows(data)
    print("Exported data to subscription_details.csv")

if __name__ == "__main__":
    main()
