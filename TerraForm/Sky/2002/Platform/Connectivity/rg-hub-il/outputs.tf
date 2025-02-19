output "hub_vnet_id" {
  value = module.hub_vnet.id
}
output "firewall_id" {
  value = module.firewall.id
}

output "subnet_ids" {
  value = module.hub_subnets.subnet_ids
}

output "firewall_name" {
  description = "The name of the Azure Firewall"
  value       = module.firewall.name # Use module output
}

output "firewall_private_ip" {
  description = "The private IP of the Azure Firewall"
  value       = module.firewall.private_ip # Ensure this is an output in the module
}

output "firewall_resource_group" {
  value = module.firewall.resource_group_name
}

