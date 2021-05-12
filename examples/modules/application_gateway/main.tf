#Web Application Firewall Policy

#WAF with for_each
data "azurerm_resource_group" "rg_search" {
  count = local.resourcegroup_state_exists == false ? 1 : 0
  name = var.resource_group_name
}

locals {
  resourcegroup_state_exists = false
}

resource "azurerm_web_application_firewall_policy" "waf" {
  resource_group_name = local.resourcegroup_state_exists == true ? var.resource_group_name : data.azurerm_resource_group.rg_search.0.name
  location = local.resourcegroup_state_exists == true ? var.resource_group_location : data.azurerm_resource_group.rg_search.0.location
  for_each = var.waf_variable
  name     = each.value["waf_name"]

  #custom_rules
   dynamic custom_rules {
     for_each = var.custom_rules
     content {
       name                    = custom_rules.value["name"]
       priority                = custom_rules.value["priority"]
       rule_type               = custom_rules.value["rule_type"]
       action                  = custom_rules.value["action"]
         match_conditions {
            match_variables {
              variable_name = custom_rules.value["variable_name"]
            }
            operator           =  custom_rules.value["operator"]
            negation_condition =  custom_rules.value["negation_condition"]
            match_values       =  custom_rules.value["match_values"]
         }
         
      } 
   }
   
  #policy setting
    policy_settings {   
    enabled                     = each.value["wafenabled"]  
    mode                        = each.value["wafmode"]   
    request_body_check          = each.value["wafcheck"]    
    file_upload_limit_in_mb     = each.value["filesize"]   
    max_request_body_size_in_kb = each.value["request_body_size"]
    }

    managed_rules {

       #using terraform var file
       dynamic exclusion {
         for_each = var.managed_rules
         content {
           match_variable          = exclusion.value["match_variable"]
           selector                = exclusion.value["selector"]
           selector_match_operator = exclusion.value["selector_match_operator"]
         }
       }       

    managed_rule_set {
      type    = each.value["managed_rule_set_type"]
      version = each.value["managed_rule_set_version"]

    }
    }

}

###########################################
 #Application Gateway
/* resource "azurerm_application_gateway" "main" {

  for_each = var.waf_variable
  //for_each = var.custom_rules
  //for_each = var.managed_rules

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  #appgw
  name                = var.application_gateway_name 

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = var.cookie_based_affinity
    port                  = var.port
    path                  = var.path
    protocol              = var.protocol
    request_timeout       = var.request_timeout
  }

  probe {
    name                  = var.probe_name
    protocol              = var.protocol
    path                  = var.path
    host                  = var.application_gateway_name
    interval              = var.interval
    timeout               = var.timeout
    unhealthy_threshold   = var.unhealthy_threshold
  }     

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = var.http_listener_protocol
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = var.rule_type
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }
   
   #waf policy
   firewall_policy_id              = azurerm_web_application_firewall_policy.waf[each.key].id
   //firewall_policy_id              = azurerm_web_application_firewall_policy.waf[*].id
}
 */
 

 ####################################3333


 #appgw with waf

 resource "azurerm_application_gateway" "main" {

 // resource_group_name = var.resource_group_name
 // location            = var.resource_group_location

 //for_each = var.waf_variable

  resource_group_name = local.resourcegroup_state_exists == true ? var.resource_group_name : data.azurerm_resource_group.rg_search.0.name
  location = local.resourcegroup_state_exists == true ? var.resource_group_location : data.azurerm_resource_group.rg_search.0.location

  #appgw
 
  for_each = var.appgw_variable
  
  name                = each.value["application_gateway_name"] 

  sku {
    name     = each.value["sku_name"]
    tier     = each.value["sku_tier"]
    capacity = each.value["sku_capacity"]
  }

  gateway_ip_configuration {
    name      = each.value["gateway_ip_configuration_name"]
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = each.value["frontend_port_name"]
    port = each.value["frontend_port"]
  }

  frontend_ip_configuration {
    name                 = each.value["frontend_ip_configuration_name"]
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name = each.value["backend_address_pool_name"]
  }

  backend_http_settings {
    name                  = each.value["http_setting_name"]
    cookie_based_affinity = each.value["cookie_based_affinity"]
    port                  = each.value["port"]
    path                  = each.value["path"]
    protocol              = each.value["protocol"]
    request_timeout       = each.value["request_timeout"]
  }

  probe {
    name                  = each.value["probe_name"]
    protocol              = each.value["protocol"]
    path                  = each.value["path"]
    host                  = each.value["application_gateway_name"]
    interval              = each.value["interval"]
    timeout               = each.value["timeout"]
    unhealthy_threshold   = each.value["unhealthy_threshold"]
  }     

  http_listener {
    name                           = each.value["listener_name"]
    frontend_ip_configuration_name = each.value["frontend_ip_configuration_name"]
    frontend_port_name             = each.value["frontend_port_name"]
    protocol                       = each.value["http_listener_protocol"]
  }

  request_routing_rule {
    name                       = each.value["request_routing_rule_name"]
    rule_type                  = each.value["rule_type"]
    http_listener_name         = each.value["listener_name"]
    backend_address_pool_name  = each.value["backend_address_pool_name"]
    backend_http_settings_name = each.value["http_setting_name"]
  }
   
  

   // for_each = var.waf_variable
   #waf policy
   //firewall_policy_id              = azurerm_web_application_firewall_policy.waf[each.key].id
  
 // firewall_policy_id = element(concat(for u in azurerm_web_application_firewall_policy.waf : waf.id], [""]), 0)

firewall_policy_id = element(concat([for u in azurerm_web_application_firewall_policy.waf : u.id], [""]), 0)
}
 

resource "azurerm_management_lock" "waf_lock" {
  for_each = var.waf_variable
  name     = "lock ${each.value["waf_name"]}"
  scope =  azurerm_web_application_firewall_policy.waf[each.key].id
  lock_level = "CanNotDelete"
  notes = "Locked by Neudesic"
  depends_on = [azurerm_web_application_firewall_policy.waf]
}

resource "azurerm_management_lock" "appgw_lock" {
  for_each = var.appgw_variable
  name     = "lock ${each.value["application_gateway_name"]}"
  scope =  azurerm_application_gateway.main[each.key].id
  lock_level = "CanNotDelete"
  notes = "Locked by Neudesic"
  depends_on = [azurerm_application_gateway.main]
}