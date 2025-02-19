provider "azurerm" {
  alias           = "connectivity"
  features {}
  subscription_id = var.connectivity_subscription_id
}

provider "azurerm" {
  alias           = "management"
  features {}
  subscription_id = var.management_subscription_id
}

provider "azurerm" {
  alias           = "SharedTools"
  features {}
subscription_id = var.sharedTools_subscription_id

}

provider "azurerm" {
  features {}
  subscription_id = var.default_subscription_id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }


# backend "azurerm" {
#     resource_group_name  = "rg-tfstorage-il"
#     storage_account_name = "tfstoragesky"
#     container_name       = "rg-monitor-il"
#     key                  = "terraform.tfstate"
#   }


  }