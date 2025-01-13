terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Ensure you're using a stable version
      
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "" # Add your subscription ID
}