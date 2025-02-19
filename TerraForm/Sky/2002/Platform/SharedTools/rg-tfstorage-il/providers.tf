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
}
provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.sharedTools_subscription_id
  alias           = "SharedTools"

}


