

variable "location" {
  description = "The Azure Region"
  default     = "israelcentral"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "rg-tfstorage-il"


}
variable "tenant_id" {
  description = ""
  default     = ""
}


variable "sharedTools_subscription_id" {
  description = "Subscription ID  sharedTools"
  default     = ""
}



variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "mystorageacct123"
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
  default     = "mycontainer"
}

variable "container_access_type" {
  description = "Container access type"
  type        = string
  default     = "private"
}
