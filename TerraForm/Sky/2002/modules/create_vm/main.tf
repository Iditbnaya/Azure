# Create a network interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
    lifecycle {
    ignore_changes = [ tags ]
  }
}



# Create the Windows virtual machine
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location

  admin_username      = var.admin_username
  admin_password      = var.admin_password
  size = var.vm_size
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
    lifecycle {
    ignore_changes = [ tags ]
  }

  # Optional: Enable TPM (if needed for Windows 11)
  # secure_boot_enabled = true
  # vtpm_enabled = true
}
