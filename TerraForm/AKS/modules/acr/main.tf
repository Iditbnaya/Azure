variable "resource_group_name" {}
variable "location" {}
variable "acr_name" {}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false

  tags = {
    Owner     = "Artur"
    CreatedBy = "Adi Bitan"
    Env       = "POC"
  }
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}