
# Modules
module "resource_group" {
  source = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "network" {
  source = "./modules/network"
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.location
  vnet_name = var.vnet_name
  subnet_name = var.subnet_name
}

module "acr" {
  source = "./modules/acr"
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.location
  acr_name = var.acr_name
}

module "aks" {
  source = "./modules/aks"
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.location
  aks_cluster_name = var.aks_cluster_name
  subnet_id = module.network.subnet_id

  
}

module "role_assignment" {
  source = "./modules/role_assignment"
  acr_id = module.acr.acr_id
  aks_principal_id = module.aks.principal_id
}
