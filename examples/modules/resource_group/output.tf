output "resource_group_name" {
  description = "resource_group_name"
  value       = azurerm_resource_group.resource_group.name
}

output "resource_group_id" {
    description = "resource_group_id"
    value       = azurerm_resource_group.resource_group.id
}

output "resource_group_location" {
    description = "resource_group_location"
    value       = azurerm_resource_group.resource_group.location
}