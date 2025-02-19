variable "firewall_policy_id" {
  description = "The ID of the Azure Firewall Policy where the rules will be added."
  type        = string
}

variable "rule_collection_group_name" {
  description = "The name of the rule collection group."
  type        = string
}

variable "priority" {
  description = "The priority of the rule collection group."
  type        = number
}

variable "rule_collection_name" {
  description = "The name of the rule collection."
  type        = string
}

variable "rule_collection_action" {
  description = "The action for the rule collection (e.g., Allow or Deny)."
  type        = string
  default     = "Allow"
}

variable "rule_priority" {
  description = "The priority of the rule within the collection."
  type        = number
}

variable "rules" {
  description               = "A map of rules to be added to the firewall policy."
  type = map(object({
    name                    = string
    #description             = string
    source_addresses        = list(string)
    destination_addresses   = list(string)
    destination_ports       = list(string)
    protocols               = list(string)
  }))
}
