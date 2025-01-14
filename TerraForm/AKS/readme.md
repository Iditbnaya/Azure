# Azure Kubernetes Service (AKS) Terraform Deployment

This repository contains Terraform configurations for deploying an Azure Kubernetes Service (AKS) cluster. The configuration is located under the [TerraForm/AKS](https://github.com/Iditbnaya/Azure/tree/main/TerraForm/AKS) directory.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Configuration Details](#configuration-details)
- [Outputs](#outputs)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

This Terraform module provisions an AKS cluster in Azure with all necessary components to run containerized workloads securely and efficiently. It supports advanced configurations like network integrations, role-based access control (RBAC), and scalability.

## Prerequisites

Before deploying the AKS cluster, ensure you have the following:

1. **Azure Account:** Ensure you have an Azure subscription with sufficient permissions.
2. **Terraform Installed:** [Download and install Terraform](https://www.terraform.io/downloads.html).
3. **Azure CLI Installed:** [Download Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
4. **Service Principal:** (Optional) If using automation, configure a service principal with permissions to manage Azure resources.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/Iditbnaya/Azure.git
cd Azure/TerraForm/AKS
```

### 2. Configure Backend (Optional)

Update the backend configuration in `main.tf` to use Azure Storage for state management.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review Variables

Update the `variables.tf` file or provide a `terraform.tfvars` file with the required values:

- `resource_group_name`: Name of the resource group.
- `location`: Azure region.
- `cluster_name`: Name of the AKS cluster.
- `node_count`: Number of nodes in the cluster.

### 5. Plan the Deployment

Run the following command to preview changes:

```bash
terraform plan
```

### 6. Apply the Configuration

Deploy the resources:

```bash
terraform apply
```

### 7. Access the AKS Cluster

Retrieve the Kubernetes configuration for the AKS cluster:

```bash
az aks get-credentials --resource-group <resource_group_name> --name <cluster_name>
kubectl get nodes
```

## Configuration Details

Key features of this AKS configuration include:

- **Network Integration**: Uses Azure CNI for advanced networking.
- **Role-Based Access Control (RBAC)**: Secures access to the cluster.
- **Auto-Scaling**: Configurable node pool scaling.
- **Monitoring**: Integration with Azure Monitor.

## Outputs

Upon successful deployment, the following outputs are available:

- `aks_cluster_name`: The name of the AKS cluster.
- `aks_fqdn`: The fully qualified domain name of the cluster.
- `node_pool_ids`: List of node pool IDs.

## Troubleshooting

### Common Issues

1. **Authentication Failure:** Ensure Azure CLI is logged in (`az login`).
2. **Insufficient Permissions:** Verify your account or service principal has the required permissions.
3. **Backend Errors:** Ensure the Azure Storage account for the backend state is correctly configured.

### Debugging

Use the following commands to debug issues:

```bash
terraform plan -out=tfplan
terraform apply tfplan
terraform show
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for feedback or improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
