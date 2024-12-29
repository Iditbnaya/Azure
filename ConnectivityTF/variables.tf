# Azure region
variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "IsraelCentral"
}

# Resource Group for Public
variable "public_rg_name" {
  description = "Resource group for Public environment"
  type        = string
  default     = "RG-Public-Hub"
}

# Resource Group for Internal
variable "internal_rg_name" {
  description = "Resource group for Internal environment"
  type        = string
  default     = "RG-Safe-Hub"
}



# Owner tag
variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "IditForPakar"
}

# Subscription ID
variable "subscription_id" {
  description = "The Azure Subscription ID where resources will be deployed"
  type        = string
  default     = "" # Replace with your  Subscription ID
}

variable "tenant_id" {
  description = ""
  default = ""

}

variable "public_routes" {
  description = "List of public routes"
  type = list(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
  }))
  default = [
    {
      name           = "route-to-internet"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

variable "internal_routes" {
  description = "List of internal routes"
  type = list(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
  }))
  default = [
    {
      name           = "route-to-internal"
      address_prefix = ""
      next_hop_type  = "VirtualAppliance"
    }
  ]
}
