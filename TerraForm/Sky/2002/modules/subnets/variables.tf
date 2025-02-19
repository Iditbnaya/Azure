variable "tags" {
  type    = map(string)
  default = {}  # Allows optional tags
}

variable "resource_group_name" {
  type = string
}
variable "virtual_network_name" {
  type = string
}
variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
