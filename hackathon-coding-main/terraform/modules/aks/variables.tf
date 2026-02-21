variable "cluster_name" {
  description = "AKS cluster name"
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

variable "dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
  default     = 2
}

variable "node_size" {
  description = "Node VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "vnet_subnet_id" {
  description = "Subnet ID for AKS nodes"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "acr_id" {
  description = "ACR ID for role assignment"
  type        = string
}

variable "enable_auto_scaling" {
  description = "Enable auto-scaling"
  type        = bool
  default     = false
}

variable "min_node_count" {
  description = "Minimum node count for auto-scaling"
  type        = number
  default     = 2
}

variable "max_node_count" {
  description = "Maximum node count for auto-scaling"
  type        = number
  default     = 5
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
