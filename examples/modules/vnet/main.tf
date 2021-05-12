
resource "azurerm_virtual_network" "main" {
  resource_group_name = var.resource_group_name 
  location            = var.resource_group_location
  name                = var.vnet_name
  address_space       = var.vnet_address_space
}
