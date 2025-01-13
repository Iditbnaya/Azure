terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3"
    }
    alz = {
      source = "Azure/alz"
    }
    azapi = {
      source = "Azure/azapi"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "4.0.4"
    # }
  }
}
provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.connectivity_subscription_id
  alias           = "connectivity"
}

provider "azurerm" {
  features {}
  subscription_id = var.shared_tools_subscription_id
  alias           = "shared_tools"
}