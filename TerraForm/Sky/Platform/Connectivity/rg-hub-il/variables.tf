

variable "location" {
  description = "The Azure Region in which all resources will be created."
  default     = "israelcentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which all resources will be created."
  default     = "rg-hub-il"


}
variable "tenant_id" {
  description = ""
  default     = ""
}


variable "connectivity_subscription_id" {
  description = "Subscription ID  connectivity"
  default     = "
}

variable "management_subscription_id" {
  description = "Subscription ID  connectivity"
  default     = ""
}


variable "default_subscription_id" {
default     = ""
}