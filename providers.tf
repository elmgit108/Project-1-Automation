# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.14.3"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "7b34c569-431d-48e1-9daf-b7f154b4e965"
}
