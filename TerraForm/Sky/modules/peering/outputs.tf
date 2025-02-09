# 

# output "peering_local_to_remote_id" {
#   value = azurerm_virtual_network_peering.local_to_remote.id
# }

# output "peering_remote_to_local_id" {
#   value = azurerm_virtual_network_peering.remote_to_local.id
# }

output "peering_id" {
  value = azurerm_virtual_network_peering.peering.id
}
