resource "azurerm_resource_group" "public_hub_rg" {
  name     = "rg-public-hub"
  location = var.location
}

resource "azurerm_resource_group" "internal_hub_rg" {
  name     = "rg-internal-hub"
  location = var.location
}

# Create Public VNet 
#Change Address space!!!
module "public_network" {
  source              = "./modules/networking"
  location            = var.location
  resource_group_name = azurerm_resource_group.public_hub_rg.name
  vnet_name           = "Public-VNet"
  address_space       = ["10.250.0.0/16"]
   tags = {
    environment = "Public"
    owner       = "yourname"
  }

  subnets = {
    AzureFirewallSubnet = {
      name           = "AzureFirewallSubnet"
      address_prefix = "10.250.1.0/24"
    },
    GWsubnet = {
      name           = "GW-subnet"
      address_prefix = "10.250.2.0/24"
    },
    Appssubnet = {
      name           = "Apps-subnet"
      address_prefix = "10.250.3.0/24"
    }
  }
}
   


#Create Internal VNet
#Change Address space!!!
module "internal_network" {
  source              = "./modules/networking"
  location            = var.location
  resource_group_name =  azurerm_resource_group.internal_hub_rg.name
  vnet_name           = "internal-vnet"
  address_space       = ["10.251.0.0/16"]
  tags = {
    environment = "Internal"
    owner       = "yourname"
  }

  subnets = {
    AzureFirewallSubnet = {
      name           = "AzureFirewallSubnet"
      address_prefix = "10.251.1.0/24" #Change Address space!!!
      private_endpoint_network_policies_enabled     = true
      private_link_service_network_policies_enabled = true
    },
    PrivateEndpointsSubnet = {
      name           = "PrivateEndpointsSubnet"
      address_prefix = "10.251.2.0/24"
      private_endpoint_network_policies_enabled     = true
      private_link_service_network_policies_enabled = true
    },
    IMgmtSubnet = {
      name           = "IMgmtSubnet"
      address_prefix = "10.251.3.0/24"
    }
    }
}


module "internal_firewall" {
  source              = "./modules/firewall"
  firewall_name       = "internal-firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.internal_hub_rg.name
  subnet_id           = module.internal_network.subnet_ids["AzureFirewallSubnet"]
  is_public           = true
  sku_tier            = "Standard"
  tags = {
    environment = "Internal"
    owner       = "YourName"
  }
}


module "public_firewall" {
  source              = "./modules/firewall"
  firewall_name       = "public-firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.public_hub_rg.name
  subnet_id           = module.public_network.subnet_ids["AzureFirewallSubnet"]
  is_public           = true
  sku_tier            = "Standard"
  tags = {
    environment = "Public"
    owner       = "YourName"
  }
}

module "route_tables" {
  source              = "./modules/route_tables"
  location            = var.location
  public_rg_name      = azurerm_resource_group.public_hub_rg.name
  internal_rg_name    = azurerm_resource_group.internal_hub_rg.name
  public_routes       = var.public_routes
  internal_routes     = var.internal_routes
  public_firewall_ip  = module.public_firewall.firewall_ip
  internal_firewall_ip = module.internal_firewall.firewall_ip
  tags = {
    environment = "Production"
    owner       = "YourName"
  }
}