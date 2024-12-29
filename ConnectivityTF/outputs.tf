
output "public_firewall_id" {
  value = module.public_firewall.firewall_id
}

output "internal_firewall_id" {
  value = module.internal_firewall.firewall_id
}


output "vnet_id_public" {
  value = module.public_network.vnet_id
}

output "vnet_id_internal" {
  value = module.internal_network.vnet_id
}
