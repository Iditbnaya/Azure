# data "azurerm_firewall" "hub_fw" {
#   name                = "fw-hub-il"  # 🔹 Replace with your actual firewall name
#   resource_group_name = "rg-hub-il"  # 🔹 Replace with the correct Hub resource group name
# }

resource "azurerm_firewall_network_rule_collection" "allow_outbound" {
  count               = module.firewall.name != "" ? 1 : 0
  name                = "AllowInternetAccess"
  azure_firewall_name = module.firewall.name                # Now this exists
  resource_group_name = module.firewall.resource_group_name # Now this exists
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "AllowAllOutbound"
    source_addresses      = ["10.0.0.0/8"] # 🔹 Adjust for your spoke VNet range
    destination_addresses = ["*"]          # 🔹 Any external IP
    protocols             = ["TCP", "UDP"]
    destination_ports     = ["80", "443"] # 🔹 Allow HTTP & HTTPS traffic
  }
}