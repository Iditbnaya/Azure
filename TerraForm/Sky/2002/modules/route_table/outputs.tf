output "route_table_id" {
  description = "The ID of the created Route Table"
  value       = azurerm_route_table.this.id
}

output "route_table_name" {
  description = "The name of the created Route Table"
  value       = azurerm_route_table.this.name
}

output "associated_subnets" {
  description = "Map of subnets associated with the route table"
  value       = azurerm_subnet_route_table_association.spoke_association
}
