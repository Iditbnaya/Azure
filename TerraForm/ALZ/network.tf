

locals {
  regions = {
    primary   = "israelcentral"
    secondary = "israelcentral"
  }
}

resource "azurerm_resource_group" "hub_rg" {
  location = local.regions.primary
  name     = "rg-hub-il"
  provider = azurerm.connectivity
}

module "hub" {
  providers = {
    azurerm = azurerm.connectivity
  }
  source = "Azure/avm-ptn-hubnetworking/azurerm"
  hub_virtual_networks = {
    primary = {
      name                            = "vnet-hub-il"
      address_space                   = ["10.0.0.0/22"]
      location                        = local.regions.primary
      resource_group_name             = azurerm_resource_group.hub_rg.name
      resource_group_creation_enabled = false
      resource_group_lock_enabled     = false
      mesh_peering_enabled            = false
      route_table_name                = "rt-hub-il"
      routing_address_space           = ["10.0.0.0/22"]
      firewall = {
        subnet_address_prefix = "10.0.0.0/26"
        name                  = "fw-hub-il"
        sku_name              = "AZFW_VNet"
        sku_tier              = "Premium"
        zones                 = ["1", "2", "3"]
        default_ip_configuration = {
          public_ip_config = {
            name  = "pip-fw-hub-il"
            zones = ["1", "2", "3"]
          }
        }
        firewall_policy = {
          name = "fwp-hub-il"
          dns = {
            proxy_enabled = true
          }
        }
      }
      subnets = {
        bastion = {
          name             = "AzureBastionSubnet"
          address_prefixes = ["10.0.0.64/26"]
          route_table = {
            assign_generated_route_table = false
          }
        }
        gateway = {
          name             = "GatewaySubnet"
          address_prefixes = ["10.0.0.128/27"]
          route_table = {
            assign_generated_route_table = false
          }
        }
        # user = {
        #   name             = "hub-user-subnet"
        #   address_prefixes = ["10.0.2.0/24"]
        # }
      }
    }
  }
}


# Spoke 1
resource "azurerm_resource_group" "shared" {
  location = local.regions.primary
  name     = "rg-shared-il"
  provider = azurerm.shared_tools
}

module "shared_vnet" {
  providers = {
    azurerm = azurerm.shared_tools
  }
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.7.1"

  name                = "vnet-shared-il"
  address_space       = ["10.0.4.0/24"]
  resource_group_name = azurerm_resource_group.shared.name
  location            = azurerm_resource_group.shared.location

  peerings = {
    "shared-peering" = {
      name                                 = "shared-peering-il"
      remote_virtual_network_resource_id   = module.hub.virtual_networks["primary"].id
      allow_forwarded_traffic              = true
      allow_gateway_transit                = false
      allow_virtual_network_access         = true
      use_remote_gateways                  = false
      create_reverse_peering               = true
      reverse_name                         = "shared-peering-back"
      reverse_allow_forwarded_traffic      = false
      reverse_allow_gateway_transit        = false
      reverse_allow_virtual_network_access = true
      reverse_use_remote_gateways          = false
    }
  }
  subnets = {
    shared-subnet = {
      name             = "shared-subnet"
      address_prefixes = ["10.0.4.0/28"]
    # To do
    #   route_table = {
    #     id = module.shared.hub_route_tables_user_subnets["primary"].id
    #   }
    }
  }
}

resource "azurerm_route_table" "shared" {
  provider = azurerm.shared_tools
  name                = "rt-shared-il"
  resource_group_name = azurerm_resource_group.shared.name
  location            = azurerm_resource_group.shared.location
  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = module.hub.firewalls["primary"].private_ip_address
  }
}
# module "vm_spoke1" {
#   source  = "Azure/avm-res-compute-virtualmachine/azurerm"
#   version = "0.15.1"

#   location                           = azurerm_resource_group.spoke1.location
#   name                               = "vm-spoke1"
#   resource_group_name                = azurerm_resource_group.spoke1.name
#   zone                               = 1
#   admin_username                     = "adminuser"
#   generate_admin_password_or_ssh_key = false

#   admin_ssh_keys = [{
#     public_key = tls_private_key.key.public_key_openssh
#     username   = "adminuser"
#   }]

#   os_type  = "linux"
#   sku_size = "Standard_B1s"

#   network_interfaces = {
#     network_interface_1 = {
#       name = "internal"
#       ip_configurations = {
#         ip_configurations_1 = {
#           name                          = "internal"
#           private_ip_address_allocation = "Dynamic"
#           private_ip_subnet_resource_id = module.spoke1_vnet.subnets["spoke1-subnet"].resource_id
#         }
#       }
#     }
#   }

#   os_disk = {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference = {
#     offer     = "0001-com-ubuntu-server-jammy"
#     publisher = "Canonical"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }


output "virtual_networks" {
  value = module.hub.virtual_networks
}