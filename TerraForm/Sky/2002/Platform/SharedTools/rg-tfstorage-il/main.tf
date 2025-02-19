provider "azurerm" {
  features {}
  subscription_id = var.sharedTools_subscription_id
}

locals {
  region = "israelcentral"
  storage_account_name = "ttttttfstoragesky"
  account_tier = "Standard"
  replication_type = "ZRS"
  container_name = "rg-hub-il"
  container_access_type = "private"
  common_tags = {
    Project     = "TFStorage"
    DateCreated = "${timestamp()}"
    Environment = "storage"
    CreatedBy   = "Idit"
  }
}



resource "azurerm_resource_group" "storage" {
name     = "rg-tfstorage-il"
location = local.region
tags     = local.common_tags
}


module "azure_storage" {
  source              = "../../../modules/storage"
  resource_group_name  = azurerm_resource_group.storage.name
  location             = local.region
  storage_account_name = local.storage_account_name
  account_tier         = local.account_tier
  replication_type     = local.replication_type
  container_name       = local.container_name
  container_access_type = local.container_access_type


}

resource "azurerm_storage_container" "additional_container_1" {
  name                  = "rg-monitor-il"
  storage_account_name  = local.storage_account_name
  container_access_type = "private"
}

# resource "azurerm_storage_container" "additional_container_2" {
#   name                  = "additionalcontainer2"
#   storage_account_name  = local.storage_account_name
#   container_access_type = "private"
#   tags                  = local.common_tags
# }