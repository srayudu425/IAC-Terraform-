# Example Terraform variables file
# Copy this file to terraform.tfvars and update with your values

location     = "eastus"
environment  = "dev"
project_name = "healthcare"

# AKS Configuration
aks_node_count = 2
aks_node_size  = "standard_dc2as_v5"

# Network Configuration
aks_vnet_address_space      = ["10.10.0.0/16"]
aks_subnet_address_prefix   = "10.10.1.0/24"
acr_subnet_address_prefix   = "10.10.2.0/24"

appgw_vnet_address_space    = ["10.12.0.0/16"]
appgw_subnet_address_prefix = "10.12.1.0/24"

# ACR Configuration
acr_sku = "Standard"

# NGINX Ingress
nginx_ingress_version = "4.8.3"
