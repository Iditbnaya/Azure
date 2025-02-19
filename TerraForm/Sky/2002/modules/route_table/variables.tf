variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "firewall_private_ip" {
  type = string
}

variable "spoke_subnet_ids" {
  type = map(string)  # Map of subnet names to IDs
}

variable "tags" {
  type    = map(string)
  default = {}
}
