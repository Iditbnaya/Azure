output "storage_account_id" {
  description = "Storage Account ID"
  value       = module.azure_storage.storage_account_id
}

output "storage_account_name" {
  description = "Storage Account Name"
  value       = module.azure_storage.storage_account_name
}

output "storage_container_url" {
  description = "Storage Container URL"
  value       = module.azure_storage.storage_container_url
}