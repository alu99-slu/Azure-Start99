terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features = {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Example: storage account for Terraform remote backend (optional, not enabled by default)
# resource "azurerm_storage_account" "tfstate" {
#   name                     = var.tf_sa_name
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }