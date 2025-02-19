# # Outputs
# output "storage_account_id" {
#     description = "The ID of the Storage Account"
#     value       = azurerm_storage_account.storage_account.id
# }

# output "storage_account_primary_endpoint" {
#     description = "The primary endpoint for the Storage Account"
#     value       = azurerm_storage_account.storage_account.primary_blob_endpoint
# }


output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "storage_container_url" {
  description = "The URL of the Storage Container"
  value       = azurerm_storage_container.container.id
}
