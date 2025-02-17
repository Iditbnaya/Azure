

# resource "azurerm_public_ip" "this" {
#   name                = var.public_ip_config.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_firewall" "this" {
#   name                = var.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku_name            = var.sku_name
#   sku_tier            = var.sku_tier
#   tags                = var.tags 

#   ip_configuration {
#     name                 = "firewall-ipconfig"
#     public_ip_address_id = azurerm_public_ip.this.id
#     subnet_id            = var.subnet_id
#   }
# }

# resource "azurerm_firewall_policy" "hub_fw_policy" {
#   name                = var.firewall.firewall_policy.name
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   dns {
#     proxy_enabled = var.firewall.firewall_policy.dns.proxy_enabled
#   }

 
# }


resource "azurerm_public_ip" "this" {
  name                = var.public_ip_config.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  tags                = var.tags 

  ip_configuration {
    name                 = "firewall-ipconfig"
    public_ip_address_id = azurerm_public_ip.this.id
    subnet_id            = var.subnet_id
  }
}

resource "azurerm_firewall_policy" "hub_fw_policy" {
  name                = var.firewall_policy.name
  resource_group_name = var.resource_group_name
  location            = var.location

  dns {
    proxy_enabled = var.firewall_policy.dns.proxy_enabled
  }
}