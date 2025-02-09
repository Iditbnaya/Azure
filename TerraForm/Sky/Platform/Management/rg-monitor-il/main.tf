

locals {
  region = "israelcentral"
  common_tags = {
    Project     = "Monitoring"
    DateCreated = "${timestamp()}"
    Environment = "management"
    CreatedBy   = "Idit"
  }
}

# data "azurerm_firewall" "hub_fw" {
#   name                = "fw-hub-il"  # 🔹 Firewall name
#   resource_group_name = "rg-hub-il"  # 🔹 Firewall resource group
# }

data "azurerm_firewall" "connectivity_fw" {
  name                = "fw-hub-il"
  resource_group_name = "rg-hub-il"

  provider = azurerm.connectivity 
}

resource "azurerm_resource_group" "monitor" {
  name     = "rg-monitor-il"
  location = local.region
  tags     = local.common_tags

  provider = azurerm.management 
}

module "monitoring_vnet" {
  source              = "../../../modules/vnet"
  name                = "vnet-monitoring-il"
  address_space       = ["10.1.0.0/25"] # Spoke VNet for monitoring
  location            = local.region
  resource_group_name = azurerm_resource_group.monitor.name
  #tags                = local.common_tags



}

module "monitoring_subnets" {
  source               = "../../../modules/subnets"
  resource_group_name  = azurerm_resource_group.monitor.name
  virtual_network_name = module.monitoring_vnet.name

  subnets = {
    log_analytics = {
      name             = "LogAnalyticsSubnet"
      address_prefixes = ["10.1.0.0/26"]
    }
    private_endpoint = {
      name             = "PrivateEndpointSubnet"
      address_prefixes = ["10.1.0.64/27"]
    }
  }
  #tags = local.common_tags
}


resource "azurerm_log_analytics_workspace" "monitor" {
  name                = "log-analytics-il"
  resource_group_name = azurerm_resource_group.monitor.name
  location            = local.region
  sku                 = "PerGB2018"
  retention_in_days   = 30
  #tags                = local.common_tags
}


module "route_table" {
  source              = "../../../modules/route_table"
  name                = "rt-spoke"
  location            = local.region
  resource_group_name = azurerm_resource_group.monitor.name
  firewall_private_ip = data.azurerm_firewall.connectivity_fw.ip_configuration[0].private_ip_address
  spoke_subnet_ids    = module.monitoring_subnets.subnet_ids
  #tags                = local.common_tags

  providers = {
    azurerm = azurerm.management
  }

}

data "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-il"
  resource_group_name = "rg-hub-il"
  provider = azurerm.connectivity
  }





module "peering_to_hub"  {
  source                     = "../../../modules/peering"
  name                         = "monitoring-to-hub"
  local_vnet_id              = module.monitoring_vnet.id
  remote_vnet_id             = data.azurerm_virtual_network.hub_vnet.id
  local_resource_group_name    = azurerm_resource_group.monitor.name
  remote_resource_group_name   = data.azurerm_virtual_network.hub_vnet.resource_group_name
  local_virtual_network_name   = module.monitoring_vnet.name
  remote_virtual_network_name  = data.azurerm_virtual_network.hub_vnet.name
 # remote_virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id

}





resource "azurerm_private_dns_zone" "logs_private_dns" {
  name                = "privatelink.logs.azure.com"
  resource_group_name = azurerm_resource_group.monitor.name
}

resource "azurerm_private_endpoint" "log_analytics_pe" {
  name                = "log-analytics-pe"
  resource_group_name = azurerm_resource_group.monitor.name
  location            = local.region
  subnet_id = module.monitoring_subnets.subnet_ids["PrivateEndpointSubnet"]

private_service_connection {
    name                           = "logs-private-link"
    private_connection_resource_id = azurerm_log_analytics_workspace.monitor.id
    subresource_names              = ["workspaces"]
    is_manual_connection           = false
  }
 
}



# #create A record in private DNS zone
# resource "azurerm_private_dns_a_record" "log_analytics_a_record" {
#   name                = "log-analytics"
#   zone_name           = azurerm_private_dns_zone.logs_private_dns.name
#   resource_group_name = azurerm_resource_group.monitor.name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.log_analytics_pe.private_ip_address]
# }
# module "private_endpoint" {
#   source               = "../modules/private_endpoint"
#   name                 = "log-pe-il"
#   resource_group_name  = azurerm_resource_group.monitor.name
#   location             = local.region
#   private_service_name = azurerm_log_analytics_workspace.monitor.id
#   subnet_id            = module.monitoring_subnets.subnet_ids["PrivateEndpointSubnet"]

#   providers = {
#     azurerm = azurerm.management
#   }
# }

