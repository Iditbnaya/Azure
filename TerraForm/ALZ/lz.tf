# This allows us to get the tenant id
data "azapi_client_config" "current" {}

provider "alz" {
  library_references = [
    {
      path = "platform/alz"
      ref  = "2024.07.3"
    },
    {
      custom_url = "${path.root}"
    }
  ]
}

module "alz_architecture" {
  providers = {
    azurerm = azurerm.connectivity
}
  source             = "Azure/avm-ptn-alz/azurerm"
  architecture_name  = "Example"
  parent_resource_id = data.azapi_client_config.current.tenant_id
  location           = "israelcentral"
  subscription_placement = {
    connectivity = {
      subscription_id       = ""
      management_group_name = "Myenv-connectivity-"
    }
    shared_tools = {
      subscription_id       = ""
      management_group_name = "Myenv-Shared_tools"
    }
  }

}

