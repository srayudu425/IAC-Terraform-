variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "healthcare"
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 2
}

variable "aks_node_size" {
  description = "Size of AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "aks_vnet_address_space" {
  description = "Address space for AKS VNET"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "Address prefix for AKS subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "acr_subnet_address_prefix" {
  description = "Address prefix for ACR subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "appgw_vnet_address_space" {
  description = "Address space for Application Gateway VNET"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "appgw_subnet_address_prefix" {
  description = "Address prefix for Application Gateway subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Standard"
}

variable "nginx_ingress_version" {
  description = "NGINX Ingress Controller version"
  type        = string
  default     = "4.8.3"
}
