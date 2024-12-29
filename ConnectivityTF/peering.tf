# Peering from Public to Internal
resource "azurerm_virtual_network_peering" "public_to_internal" {
  name                      = "public-to-internal"
  resource_group_name       = azurerm_resource_group.public_hub_rg.name
  virtual_network_name      = module.public_network.vnet_name
  remote_virtual_network_id = module.internal_network.vnet_id
  allow_virtual_network_access = true

  depends_on = [module.public_network, module.internal_network]
  
}

# Peering from Internal to Management
resource "azurerm_virtual_network_peering" "internal_to_public" {
  name                      = "internal-to-public"
  resource_group_name       = azurerm_resource_group.internal_hub_rg.name
  virtual_network_name      = module.internal_network.vnet_name
  remote_virtual_network_id = module.public_network.vnet_id
  allow_virtual_network_access = true

  depends_on = [module.internal_network, module.public_network]
 
}
