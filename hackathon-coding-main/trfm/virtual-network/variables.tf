variable "AKS_ACR_VNET_NAME" { type = string }
variable "AKS_ACR_ADDRESS_SPACE" { type = string }
variable "AKS_SUBNET_NAME" { type = string }
variable "AKS_SUBNET_ADDRESS_PREFIX" { type = string }
variable "ACR_SUBNET_NAME" { type = string }
variable "ACR_SUBNET_ADDRESS_PREFIX" { type = string }

variable "LOCATION" { type = string }
variable "RESOURCE_GROUP_NAME" { type = string }

variable "APPGW_VNET_NAME" { type = string }
variable "APPGW_SUBNET_NAME" { type = string }
variable "APPGW_SUBNET_ADDRESS_PREFIX" { type = string }
variable "APPGW_ADDRESS_SPACE" { type = string }
