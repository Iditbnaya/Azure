variable "hub_vnet_id" {
  type    = string
  default = "/subscriptions/593fef75522/resourceGroups/rg-hub-il/providers/Microsoft.Network/virtualNetworks/vnet-hub-il"
}
variable "tags" {
  type    = map(string)
  default = {} # Allows optional tags
}


variable "location" {
  description = "The Azure Region in which all resources will be created."
  default     = "israelcentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which all resources will be created."
  default     = "rg-monitor-il"


}
variable "tenant_id" {
  description = ""
  default     = ""
}


variable "management_subscription_id" {
  description = "Subscription ID  connectivity"
  default     = ""
}


variable "connectivity_subscription_id" {
  description = "Subscription ID  connectivity"
  default     = ""
}

variable "sharedTools_subscription_id" {
  description = "Subscription ID  sharedTools"
  default     = ""
}

variable "default_subscription_id" {
default     = ""
}

