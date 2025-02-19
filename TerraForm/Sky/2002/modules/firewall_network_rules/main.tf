resource "azurerm_firewall_policy_rule_collection_group" "firewall_rules" {
  name               = var.rule_collection_group_name
  firewall_policy_id = var.firewall_policy_id
  priority           = var.priority

  network_rule_collection {
    name     = var.rule_collection_name
    action   = var.rule_collection_action
    priority = var.rule_priority

    dynamic "rule" {
      for_each = var.rules
      content {
        name                  = rule.value.name
        #description           = rule.value.description
        source_addresses      = rule.value.source_addresses
        destination_addresses = rule.value.destination_addresses
        destination_ports     = rule.value.destination_ports
        protocols             = rule.value.protocols
      }
    }
  }
}
