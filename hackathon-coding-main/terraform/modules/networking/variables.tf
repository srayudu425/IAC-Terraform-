variable "vnet_name" {
  description = "Virtual network name"
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

variable "address_space" {
  description = "Address space for VNET"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
