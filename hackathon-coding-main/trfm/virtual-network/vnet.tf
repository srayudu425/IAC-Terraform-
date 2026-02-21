## we are going to create 3 virtual network one for AKS , second for ACR and other Resource and third for selfhosted agents#

resource "azurerm_virtual_network" "aks-acr-vnet" {
  name                = var.AKS_ACR_VNET_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
  address_space       = [var.AKS_ACR_ADDRESS_SPACE]
}

resource "azurerm_subnet" "aks-subnet" {
  name                 = var.AKS_SUBNET_NAME
  resource_group_name  = var.RESOURCE_GROUP_NAME
  virtual_network_name = azurerm_virtual_network.aks-acr-vnet.name
  address_prefixes     = [var.AKS_SUBNET_ADDRESS_PREFIX]

}

resource "azurerm_subnet" "acr-subnet" {
  name                 = var.ACR_SUBNET_NAME
  resource_group_name  = var.RESOURCE_GROUP_NAME
  virtual_network_name = azurerm_virtual_network.aks-acr-vnet.name
  address_prefixes     = [var.AKS_SUBNET_ADDRESS_PREFIX]

}

resource "azurerm_virtual_network" "appgw-vnet" {
  name                = var.APPGW_VNET_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
  address_space       = [var.APPGW_ADDRESS_SPACE]

  subnet {
    name           = var.APPGW_SUBNET_NAME
    address_prefix = var.APPGW_SUBNET_ADDRESS_PREFIX
  }
  
}

resource "azurerm_virtual_network_peering" "aks-appgw" {
  name                      = "akstoacr"
  resource_group_name       = var.RESOURCE_GROUP_NAME
  virtual_network_name      = azurerm_virtual_network.aks-acr-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.appgw-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}
resource "azurerm_virtual_network_peering" "appgw-aks" {
  name                      = "acrtoaks"
  resource_group_name       = var.RESOURCE_GROUP_NAME
  virtual_network_name      = azurerm_virtual_network.appgw-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.aks-acr-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}
