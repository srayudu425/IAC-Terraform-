# Resource Groups
module "aks_rg" {
  source = "./modules/resource-group"
  
  name     = "${var.project_name}-aks-${var.environment}-rg"
  location = var.location
}

module "monitoring_rg" {
  source = "./modules/resource-group"
  
  name     = "${var.project_name}-monitoring-${var.environment}-rg"
  location = var.location
}

module "appgw_rg" {
  source = "./modules/resource-group"
  
  name     = "${var.project_name}-appgw-${var.environment}-rg"
  location = var.location
}

# Networking - AKS VNET
module "aks_networking" {
  source = "./modules/networking"
  
  vnet_name           = "${var.project_name}-aks-vnet"
  resource_group_name = module.aks_rg.name
  location            = var.location
  address_space       = var.aks_vnet_address_space
  
  subnets = {
    aks = {
      name             = "aks-subnet"
      address_prefixes = [var.aks_subnet_address_prefix]
    }
    acr = {
      name             = "acr-subnet"
      address_prefixes = [var.acr_subnet_address_prefix]
    }
  }
}

# Networking - Application Gateway VNET
module "appgw_networking" {
  source = "./modules/networking"
  
  vnet_name           = "${var.project_name}-appgw-vnet"
  resource_group_name = module.appgw_rg.name
  location            = var.location
  address_space       = var.appgw_vnet_address_space
  
  subnets = {
    appgw = {
      name             = "appgw-subnet"
      address_prefixes = [var.appgw_subnet_address_prefix]
    }
  }
}

# VNET Peering
module "vnet_peering" {
  source = "./modules/vnet-peering"
  
  vnet1_name          = module.aks_networking.vnet_name
  vnet1_id            = module.aks_networking.vnet_id
  vnet1_rg_name       = module.aks_rg.name
  
  vnet2_name          = module.appgw_networking.vnet_name
  vnet2_id            = module.appgw_networking.vnet_id
  vnet2_rg_name       = module.appgw_rg.name
}

# Monitoring
module "monitoring" {
  source = "./modules/monitoring"
  
  resource_group_name = module.monitoring_rg.name
  location            = var.location
  environment         = var.environment
  project_name        = var.project_name
}

# ACR
module "acr" {
  source = "./modules/acr"
  
  name                = "${var.project_name}acr${var.environment}"
  resource_group_name = module.aks_rg.name
  location            = var.location
  sku                 = var.acr_sku
  subnet_id           = module.aks_networking.subnet_ids["acr"]
}

# AKS
module "aks" {
  source = "./modules/aks"
  
  cluster_name        = "${var.project_name}-aks-${var.environment}"
  resource_group_name = module.aks_rg.name
  location            = var.location
  dns_prefix          = "${var.project_name}-aks-${var.environment}"
  
  node_count          = var.aks_node_count
  node_size           = var.aks_node_size
  
  vnet_subnet_id      = module.aks_networking.subnet_ids["aks"]
  
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  
  acr_id              = module.acr.acr_id
}

# NGINX Ingress Controller
module "nginx_ingress" {
  source = "./modules/nginx-ingress"
  
  depends_on = [module.aks]
  
  chart_version = var.nginx_ingress_version
}

# Application Gateway
module "application_gateway" {
  source = "./modules/application-gateway"
  
  name                = "${var.project_name}-appgw-${var.environment}"
  resource_group_name = module.appgw_rg.name
  location            = var.location
  
  subnet_id           = module.appgw_networking.subnet_ids["appgw"]
  
  aks_cluster_name    = module.aks.cluster_name
  aks_rg_name         = module.aks_rg.name
}
