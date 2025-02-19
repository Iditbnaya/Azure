# variable "storage_account_name" {
#     description = "The name of the storage account."
#     type        = string
# }

# variable "resource_group_name" {
#     description = "The name of the resource group."
#     type        = string
# }

# variable "location" {
#     description = "The location of the resource group."
#     type        = string
# }

# variable "account_tier" {
#     description = "Defines the Tier to use for this storage account."
#     type        = string
#     default     = "Standard"
# }

# variable "account_replication_type" {
#     description = "Defines the type of replication to use for this storage account."
#     type        = string
#     default     = "LRS"
# }

# variable "tags" {
#     description = "A map of tags to assign to the resource."
#     type        = map(string)
#     default     = {}
# }

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "The replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "container_access_type" {
  description = "The access type of the storage container"
  type        = string
  default     = "private"
}
