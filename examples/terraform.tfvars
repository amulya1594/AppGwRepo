#Provider
subscription_id  = "0e2b673d-7c5e-4130-99a5-505146ab8ac1"
client_id        = "990d3c7f-ee2e-4d33-aa71-72f15558b784"
client_secret    = "ruIpNGrItm6HAY.83.3F2Ev._fp9fUb1r2"
tenant_id        = "317410c9-979d-401c-a3cc-5bf68d88561d" 

  //create_resource_group                      = true
  resource_group_name                        = "waf"
  resource_group_location                    = "EastUS"

  /* tags = {
    environment = "dev"
    created_by  = "amulya"
  } */

#WAF

  waf_variable = {
  "waf_variable1" = {
    waf_name= "wafpolicy"
    wafenabled= "true"
    wafmode= "Prevention"
    wafcheck= "true"
    filesize= "100"
    request_body_size= "128"
    managed_rule_set_type= "OWASP"
    managed_rule_set_version= "3.1"
  },

   "waf_variable2" = {
    waf_name= "wafpolicy"
    wafenabled= "true"
    wafmode= "Detection"
    wafcheck= "true"
    filesize= "100"
    request_body_size= "128"
    managed_rule_set_type= "OWASP"
    managed_rule_set_version= "3.1"
     
   }
}

#managed_rules
managed_rules = {
  "managed_rule1" = {
    match_variable          = "RequestHeaderNames"
    selector                = "x-company-secret-header"
    selector_match_operator = "Equals"
  },
  "managed_rule2" = {
    match_variable          = "RequestCookieNames"
    selector                = "too-tasty"
    selector_match_operator = "EndsWith"
  }
}  

#custom_rules
custom_rules = {
  "custom_rule1" = {
       name= "Rule1"
       priority = "1"
       rule_type = "MatchRule"
       action = "Block" 
       operator = "IPMatch"
       negation_condition = "false"
       match_values = ["192.168.1.0/24", "10.0.0.0/24"]  
       variable_name = "RemoteAddr"    
  },
  "custom_rule2" = {
     name= "Rule2"
     priority = "2"
     rule_type = "MatchRule"
     action = "Block"  
     operator           = "Contains"  
     negation_condition = "false"
     match_values = ["Windows"]   
     variable_name = "RequestHeaders"
  }
} 


#Appgw with WAF

#Vnet variables
vnet_name                       = "terraformvnet"
vnet_address_space              = ["10.0.0.0/16"]

#Subnet variables
subnet_name                     = "mainsubnet"
subnet_address_prefixes         = ["10.0.0.0/24"]

#Public IP variables
public_ip_name                  = "appgateway_pip"
public_ip_allocation_method     = "Static"
//public_ip_sku                   = "Basic"
public_ip_sku                   = "Standard"

 

/* 
#Application gateway
backend_address_pool_name       = "backend_address_pool"
frontend_port_name              = "frontend_port"
frontend_ip_configuration_name  = "frontend_ip_configuration"
http_setting_name               = "http_setting"
listener_name                   = "listener"
request_routing_rule_name       = "request_routing_rule"
redirect_configuration_name     = "redirect_configuration"

#Application gateway name
application_gateway_name        = "appgatewayforweb"

#SKU for application gateway
//sku_name                        = "Standard_Small"
sku_name                        = "WAF_v2"
//sku_tier                        = "Standard"
sku_tier                        = "WAF_v2"
sku_capacity                    = "2"

#Gateway IP configuration
gateway_ip_configuration_name   = "gateway_ip"

frontend_port                   = "80"

#Backend HTTP setting
cookie_based_affinity           = "Disabled"
port                            = "80"
path                            = "/"
protocol                        = "Http"
request_timeout                 = "60"

#probe
probe_name                      = "probe"
interval                        = "30"
timeout                         = "30"
unhealthy_threshold             = "3"

#HTTP listener protocol
http_listener_protocol          = "HttP"

#Request routing rule
rule_type                       = "Basic"
 */

 

#appgw with for_each

appgw_variable = {
  "appgw_variable1" = {
    application_gateway_name= "appgatewayforweb"
    sku_name= "WAF_v2"
    sku_tier                        = "WAF_v2"
    sku_capacity                    = "2"
    gateway_ip_configuration_name   = "gateway_ip"
    frontend_port                   = "80"
    backend_address_pool_name       = "backend_address_pool"
    frontend_port_name              = "frontend_port"
    frontend_ip_configuration_name  = "frontend_ip_configuration"
    http_setting_name               = "http_setting"
    listener_name                   = "listener"
    request_routing_rule_name       = "request_routing_rule"
    redirect_configuration_name     = "redirect_configuration"
    #Backend HTTP setting
    cookie_based_affinity           = "Disabled"
    port                            = "80"
    path                            = "/"
    protocol                        = "Http"
    request_timeout                 = "60"
    #probe
    host                            = "appgatewayforweb"
    probe_name                      = "probe"
    interval                        = "30"
    timeout                         = "30"
    unhealthy_threshold             = "3"
    #HTTP listener protocol
    http_listener_protocol          = "HttP"
   #Request routing rule
   rule_type                       = "Basic"

  }
}  