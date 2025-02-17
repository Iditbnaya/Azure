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
  subscription_id = var.connectivity_subscription_id
  alias           = "connectivity"

}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.management_subscription_id
  alias           = "management"

}

# provider "azurerm" {
#   features {}
#   subscription_id = var.default_subscription_id
# }



