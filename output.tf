output "waf_id" {
    value = values(azurerm_web_application_firewall_policy.waf)[*].id
}