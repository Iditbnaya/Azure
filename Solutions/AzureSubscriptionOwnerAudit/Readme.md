# Azure Subscription Audit

A Python script to audit Azure subscriptions, fetch details, and export them to a CSV file. This tool helps identify subscription statuses, owner counts, and inheritance details for Azure AD permissions.

## Features

- Counts and lists Azure subscriptions.
- Identifies disabled subscriptions.
- Counts unique owners and determines if permissions are inherited or direct.
- Resolves Azure AD group memberships to individual users.
- Exports subscription details to a CSV file.

## Requirements

- Python 3.7 or later.
- Azure account with appropriate permissions.

## Dependencies

Install the required libraries using the following command:

```bash
pip install -r requirements.txt
```

### Required Python Packages

- `azure-identity`
- `azure-mgmt-resource`
- `azure-mgmt-authorization`
- `azure-graphrbac`
- `tabulate`

## Setup

1. Create a virtual environment (optional but recommended):

```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\\Scripts\\activate
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Ensure your Azure CLI is authenticated:

```bash
az login
```

## Usage

Run the script using the command:

```bash
python subscription_details.py
```

The script will:
1. Fetch subscription details.
2. Print a summary of the subscriptions.
3. Export the details to a `subscription_details.csv` file.

## CSV Output

The exported CSV contains the following columns:
- `Subscription Name`
- `Subscription ID`
- `Owner Count`
- `Is Disabled`
- `Inheritance`

## Permissions

Ensure your account has the following permissions:
- **Reader** role on subscriptions.
- Azure Active Directory permissions:
  - `Directory.Read.All` for resolving group memberships.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bugs.

