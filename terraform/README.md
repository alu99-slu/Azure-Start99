Terraform skeleton for Azure starter
- This folder contains minimal Terraform files to get started.
- It does NOT configure a remote backend by default.

To use (local state):
1. Install Terraform.
2. Set Azure credentials (AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID) or use `az login`.
3. cd terraform
4. terraform init
5. terraform apply

If you want a remote backend (Azure Storage):
- Create a storage account & container and set backend values in backend.tf or provide them as environment variables.