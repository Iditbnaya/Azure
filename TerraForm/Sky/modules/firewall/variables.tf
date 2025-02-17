# variable "name" {
#   type = string
# }
# variable "subnet_id" {
#   type = string
# }
# variable "sku_name" {
#   type = string
# }
# variable "sku_tier" {
#   type = string
# }
# variable "public_ip_config" {
#   type = object({
#     name = string
#   })
# }
# variable "firewall_policy" {
#   type = object({
#     name = string
#   })
# }
# variable "location" {
#   type = string
# }
# variable "resource_group_name" {
#   type = string
# }
# variable "virtual_network_name" {
#   type = string
# }

# variable "tags" {
#   type    = map(string)
#   default = {}  # Allows optional tags
# }
# variable "firewall_policy_name" {
#   type = string
# }

# # variable "rule_collection_group_name" {
# #   type = string
# # }

# # variable "rule_collection_group_priority" {
# #   type = number
# # }
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnet_id" {
  type = string
}

variable "public_ip_config" {
  type = object({
    name = string
  })
}

variable "firewall_policy" {
  type = object({
    name = string
    dns = object({
      proxy_enabled = bool
    })
  })
}