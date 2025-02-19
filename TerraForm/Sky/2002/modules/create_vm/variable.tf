variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the VM."
}

variable "location" {
  type        = string
  description = "The Azure region in which to create the VM."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to connect the VM to."
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine."
  default     = "windows-vm"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine."
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  type        = string
  description = "The username for the administrator account."
  default     = "adminuser"
}

variable "admin_password" {
  type        = string
  description = "The password for the administrator account."
  sensitive   = true
}

variable "image_publisher" {
  type        = string
  description = "The publisher of the OS image."
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  type        = string
  description = "The offer of the OS image."
  default     = "WindowsServer"
}

variable "image_sku" {
  type        = string
  description = "The SKU of the OS image."
  default     = "2019-Datacenter"
}

variable "image_version" {
  type        = string
  description = "The version of the OS image."
  default     = "latest"
}

variable "disk_caching" {
  type = string
  description = "Disk caching of the machine"
  default = "ReadWrite"
}

variable "storage_account_type" {
  type = string
  description = "Storage account type of the machine"
  default = "Standard_LRS"
}

variable "private_ip_address_allocation" {
  type = string
  description = "IP allocation of the machine"
  default = "Dynamic"
}

variable "ip_name" {
  type = string
  description = "name of the ipconfiguration"
  default = "internal"
}