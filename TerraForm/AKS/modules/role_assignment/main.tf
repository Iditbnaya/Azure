# FILE: modules/role_assignment/main.tf
variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}

variable "aks_principal_id" {
  description = "The principal ID of the AKS cluster"
  type        = string
}

resource "azurerm_role_assignment" "acr_role_assignment" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_principal_id
}