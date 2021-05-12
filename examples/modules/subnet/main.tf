resource "azurerm_subnet" "main" {
  resource_group_name  = var.resource_group_name
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes
}