data "azurerm_client_config" "current" {}

data "azurerm_subnet" "sa_subnet" {
  name                 = "aks-00"
  virtual_network_name = "cft-ptl-vnet"
  resource_group_name  = "cft-ptl-network-rg"
}