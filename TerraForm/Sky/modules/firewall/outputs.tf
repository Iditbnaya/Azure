output "id" {
  value = azurerm_firewall.this.id
}
output "name" {
  value = azurerm_firewall.this.name
}

output "private_ip" {
  value = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "resource_group_name" {
  value = azurerm_firewall.this.resource_group_name
}