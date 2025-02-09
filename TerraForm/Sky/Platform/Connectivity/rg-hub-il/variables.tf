# variable "name" {
#   type = string
# }

# # variable "address_space" {
# #   type = list(string)
# # }

# # variable "location" {
# #   type = string
# # }

# variable "resource_group_name" {
#   type = string
# }

# variable "subnets" {
#   type = map(object({
#     name             = string
#     address_prefixes = list(string)
#   }))
# }

# variable "sku_name" {
#   type = string
# }

# variable "sku_tier" {
#   type = string
# }


variable "location" {
  description = "The Azure Region in which all resources will be created."
  default     = "israelcentral"
}

variable "resource_group_name" {
  description = "The name of the resource group in which all resources will be created."
  default     = "rg-hub-il"


}
variable "tenant_id" {
  description = "The Tenant ID"
  default     = "XXXXXX"
}


variable "connectivity_subscription_id" {
  description = "Subscription ID  connectivity"
  default     = ""
}

variable "management_subscription_id" {
  description = "Subscription ID  Management"
  default     = ""
}


variable "default_subscription_id(connectivity)" {
default     = ""
}