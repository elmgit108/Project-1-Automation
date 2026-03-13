# Backend bootstrap — uses LOCAL state (no remote backend needed)
# Run this ONCE before initializing the main Project1 module:
#   cd backend && tfi && tfa && cd ..
# Then run tfi in Project1 to connect to the remote backend.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
  }
  required_version = "~> 1.14.3"
}

provider "azurerm" {
  features {}
  subscription_id = "7b34c569-431d-48e1-9daf-b7f154b4e965"
}

# Backend Resource Group
resource "azurerm_resource_group" "tfstate_rg" {
  name     = "tfstateN01017431RG"
  location = "Canada Central"
}

# Backend Storage Account
resource "azurerm_storage_account" "tfstate_sa" {
  name                     = "tfstaten01017431sa"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob Container for state files
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstatefiles"
  storage_account_id    = azurerm_storage_account.tfstate_sa.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate_sa.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate_container.name
}
