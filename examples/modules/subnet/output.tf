output "subnet_id" {
  description = "subnet id"
  value       = azurerm_subnet.main.id
}

output "subnet_name" {
  description = "subnet_name"
  value       = azurerm_subnet.main.name
}