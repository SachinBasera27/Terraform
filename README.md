# Terraform Azure CI/CD with GitHub Actions

## Step 1: Create Backend Resources

- Created an Azure Resource Group.
- Created an Azure Storage Account.
- Created the blob container for Terraform remote state.
- Configured the AzureRM backend with the state key to store the state file securely.

## Step 2: Configure Azure Authentication

- Created an Azure App Registration and Service Principal.
- Assigned the `Contributor` role at the subscription level.
- Assigned the `Storage Blob Data Contributor` role for the Terraform state storage account/container.
- Configured GitHub Actions federated credentials for passwordless OIDC authentication.

[Microsoft Entra Federated Credentials Documentation](https://learn.microsoft.com/en-us/entra/identity-platform/how-to-add-credentials)

## Step 3: Configure GitHub Actions

- Added GitHub secrets for Azure Client ID, Tenant ID, and Subscription ID.
- Added `id-token: write` permission for OIDC authentication.
- Created workflows for Terraform plan, apply, and targeted resource destruction.
- Configured Terraform to use the Azure Storage remote backend.

## Step 4: Deploy Infrastructure

- Ran `terraform init`.
- Ran `terraform fmt`.
- Ran `terraform validate`.
- Ran `terraform plan`.
- Ran `terraform apply`.
- Deployed the VNet, subnet, NIC, managed disk, and Windows VM.
- Confirmed Terraform state is stored in Azure Blob Storage.

## Issues Encountered and Fixes

### OIDC Federated Identity Error

- Received the `AADSTS700213` federated identity error.
- GitHub sent an immutable subject containing GitHub owner and repository IDs.
- Updated the App Registration federated credential subject to exactly match the subject shown in the GitHub Actions error.
- Re-ran the workflow successfully.

[Microsoft Entra Workload Identity Federation Documentation](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation)

### Terraform Formatting Error

- `terraform fmt -check` failed because `backend.tf` was not formatted.
- Ran `terraform fmt`.
- Pushed the formatted file and re-ran the workflow.

### VM Capacity Restriction

- `Standard_D4_v5` was unavailable in the `Central US` region.
- Changed to an available VM size while keeping the same region.
- Re-ran Terraform apply successfully.

[Azure VM Allocation Troubleshooting Documentation](https://learn.microsoft.com/en-us/troubleshoot/azure/virtual-machines/windows/allocation-failure)

## Step 5: Destroy Test Resources

- Added a manual GitHub Actions workflow named `terraform-destroy.yml`.
- The workflow destroys only the test VM, managed disk, NIC, subnet, and VNet.
- The Resource Group, Storage Account, Blob Container, and remote Terraform state file are not targeted.

### Safety Check

- The destroy job runs only when the exact value `DESTROY` is entered.
- It can be modified to run with just manual action without having to give in any input.
- Any other value causes the destroy job to be skipped.
- Terraform uses `-auto-approve` only after the `DESTROY` confirmation check succeeds.

## Step 6: Updated Repo name to Terraform-VM from Terraform

- To validate that the 'immutable subject claims' works and renaming the repo wouldn't break the trust between the Azure and Github.


Architecture:

```text
Terraform/
│
├── .github/
│   └── workflows/
│       ├── terraform-build.yml
│       └── terraform-deploy.yml
│
├── modules/
│   ├── networking/
|     └── networkMain.tf
|     └── netOut.tf
│   ├── storage/
|      └── storageMain.tf
|      └── storageOut.tf
│   ├── Resource
|      └── resourceMain.tf
|      └── resourceOut.tf
│
├── backend.tf
├── providers.tf
├── main.tf
├── .gitignore
│    └── terraform.exe
|    └── Working Directory files which include providers and modules
|    └── Terraform state files
|    └── Terraform plan files
└── README.md
```
