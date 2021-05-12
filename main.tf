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
