output "monitoring_vnet_id" {
  value = module.monitoring_vnet.id
}

output "monitoring_subnet_ids" {
  value = module.monitoring_subnets.subnet_ids
}

# output "log_analytics_id" {
#   value = module.log_analytics.id
# }

# output "private_endpoint_id" {
#   value = module.private_endpoint.id
# }

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.monitor.id
}

