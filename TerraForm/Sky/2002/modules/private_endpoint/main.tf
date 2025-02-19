

# terraform {
#   required_providers {
#     azurerm = {
#       source = "hashicorp/azurerm"
#     }
#   }
# }

# resource "azurerm_private_endpoint" "this" {
#   name                = var.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.subnet_id

#   private_service_connection {
#     name                           = "${var.name}-connection"
#     private_connection_resource_id = var.private_service_name
#     subresource_names              = ["workspace"]
#     is_manual_connection           = false
#   }

#   provider = azurerm.connectivity 
# }

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.private_service_name
    subresource_names              = ["workspace"]
    is_manual_connection           = false
  }
}
