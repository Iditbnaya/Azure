resource "azurerm_firewall_network_rule_collection" "allow_outbound" {
  count               = module.firewall.name != "" ? 1 : 0
  name                = "AllowInternetAccess"
  azure_firewall_name = module.firewall.name                
  resource_group_name = module.firewall.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "AllowAllOutbound"
    source_addresses      = ["10.0.0.0/8"] # Adjust for your spoke VNet range
    destination_addresses = ["*"]          # Any external IP
    protocols             = ["TCP", "UDP"]
    destination_ports     = ["80", "443"]  # Allow HTTP & HTTPS traffic
  }
}

data "azurerm_firewall_policy" "fw-policy" {
  name                = "fp-hub-il"
  resource_group_name = "rg-hub-il"
  #provider = azurerm.connectivity
}

# Add rules for public firewall
module "firewall_rules" {
  source                     = "../../../modules/firewall_network_rules"
  firewall_policy_id         = data.azurerm_firewall_policy.fw-policy.id
  rule_collection_group_name = "network-rules"
  priority                   = 100
  rule_collection_name       = "rules"
  rule_collection_action     = "Allow"
  rule_priority              = 100

  rules = {
    allow_all_outbound = {
      name                  = "AllowAllOutbound"
      source_addresses      = ["10.0.0.0/8"]
      destination_addresses = ["*"]
      protocols             = ["TCP", "UDP"]
      destination_ports     = ["80", "443"]
    }
  }
}