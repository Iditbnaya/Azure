
variable "resource_group_name" {}
variable "location" {}
variable "aks_cluster_name" {}
variable "subnet_id" {}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-rail"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "standard_d2plds_v6"
    vnet_subnet_id = var.subnet_id
  }

  network_profile {
    network_plugin    = "kubenet"
    service_cidr      = "10.0.0.0/20"
    dns_service_ip    = "10.0.0.10"
    pod_cidr          = "10.224.0.0/20"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    #docker_bridge_cidr = "172.17.0.1/16"
  }

  private_cluster_enabled = true
  private_dns_zone_id     = null # Using system-managed private DNS

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Owner     = ""
    CreatedBy = ""
    Env       = ""
  }
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}