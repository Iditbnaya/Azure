
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

variable "zones" {
  type = list(number)
}