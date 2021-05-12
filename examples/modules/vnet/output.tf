output "vnet_id" {
  description = "VNet id"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "vnet_name"
  value       = azurerm_virtual_network.main.name
}

output "location" {
  description = "location"
  value = azurerm_virtual_network.main.location
}