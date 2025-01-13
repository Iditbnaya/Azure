# Variables for customization
variable "resource_group_name" {
  default = ""
}

variable "location" {
  default = "westeurope" # Choose your preferred region
}

variable "vnet_name" {
  default = "AKSVnet"
}

variable "subnet_name" {
  default = ""
}

variable "aks_cluster_name" {
  default = ""
}

variable "acr_name" {
  default = ""
}

