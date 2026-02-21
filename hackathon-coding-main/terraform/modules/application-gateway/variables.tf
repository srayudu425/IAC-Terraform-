variable "name" {
  description = "Application Gateway name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Application Gateway"
  type        = string
}

variable "sku_name" {
  description = "SKU name"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "SKU tier"
  type        = string
  default     = "Standard_v2"
}

variable "capacity" {
  description = "Capacity (number of instances)"
  type        = number
  default     = 2
}

variable "aks_cluster_name" {
  description = "AKS cluster name for backend pool"
  type        = string
  default     = ""
}

variable "aks_rg_name" {
  description = "AKS resource group name"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
