variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "subnet_name" {}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.220.0.0/21"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.220.0.0/22"]
}

output "subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}