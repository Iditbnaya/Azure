resource "azurerm_public_ip" "bastion_ip" {
  provider            = azurerm.connectivity
  name                = "bastion-ip-hub-il"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                  = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  provider            = azurerm.connectivity
  name                = "bastion-host-hub-il"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
 # dns_name            = "bastion-host-hub-il"
  
  ip_configuration {
    name                 = "bastion-ip-config"
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
    subnet_id            = module.hub.virtual_networks["primary"].subnet_ids["primary-bastion"]
  }
}

resource "azurerm_network_interface" "vm_nic" {
  provider            = azurerm.shared_tools
  name                = "vm-nic-shared-il"
  location            = azurerm_resource_group.shared.location
  resource_group_name = azurerm_resource_group.shared.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = module.shared_vnet.subnets["shared-subnet"].resource_id
  }
}

resource "azurerm_windows_virtual_machine" "vm_test" {
  provider            = azurerm.shared_tools
  name                = "vm-test-il"
  location            = azurerm_resource_group.shared.location
  resource_group_name = azurerm_resource_group.shared.name
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]
  size                = "Standard_D4s_v3"
  admin_username      = "azureuser"
  admin_password      = "Password1234!@" 

  os_disk {
    name                 = "os-disk-vm-shared-il"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }


  tags = {
    environment = "test"
  }
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.vm_test.id
  }
output  "vm_ip_address" {
  value = azurerm_windows_virtual_machine.vm_test.private_ip_address
}

