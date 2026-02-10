terraform {
  backend "azurerm" {
    # Replace these values after you create the storage account & container (see instructions below).
    resource_group_name  = "REPLACE_WITH_RG_NAME"
    storage_account_name = "REPLACE_WITH_STORAGE_ACCOUNT"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}