output "public_ip_id" {
  description = "public ip id"
  value       = azurerm_public_ip.main.id
}

output "public_ip_name" {
  description = "public_ip_name"
  value       = azurerm_public_ip.main.name
}

output "location" {
  description = "public_ip_location"
  value       = azurerm_public_ip.main.location
}