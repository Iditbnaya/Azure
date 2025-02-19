# 

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_virtual_network_peering" "peering" {
  name                         = "${var.name}-peering"
  resource_group_name          = var.local_resource_group_name
  virtual_network_name         = var.local_virtual_network_name
  remote_virtual_network_id    = var.remote_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# resource "azurerm_virtual_network_peering" "remote_to_local" {
#   name                         = "${var.name}-remote-to-local"
#   resource_group_name          = var.remote_resource_group_name
#   virtual_network_name         = var.remote_virtual_network_name
#   remote_virtual_network_id    = var.local_vnet_id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
#   allow_gateway_transit        = false
#   use_remote_gateways          = false
# }
