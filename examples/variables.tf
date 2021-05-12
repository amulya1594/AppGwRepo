#provider_ids
variable "subscription_id"{
    description = "subscription_id"
    type = string
}

variable "client_id"{
    description = "client_id"
    type = string
}

variable "client_secret"{
    description = "client_secret"
    type = string
}

variable "tenant_id"{
    description = "tenant_id"
    type = string
}

/* 
#resource_group
variable "resource_group_name"{
    description = "name of rg"
    type = string
    default = "myrg"
}

variable "resource_group_location"{
    description = "location of rg"
    type = string
    default = "eastus2"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

#waf
 variable "waf_variable" {
    type = map(object({
       waf_name= string
       wafenabled= string
       wafmode= string
       wafcheck= string
       filesize= string
       request_body_size= string
       managed_rule_set_type= string
       managed_rule_set_version= string

    }))
}

variable "managed_rules" {
    type = map(object({
       match_variable= string
       selector= string
       selector_match_operator= string
    }))
}  

variable "custom_rules" {
    type = map(object({
       name= string
       priority = string
       rule_type = string
       action = string
       operator           = string
       negation_condition = string
       match_values = list(string)
       variable_name = string
       
    }))
} 

 */
#########################################################

#resource_group
variable "resource_group_name" {
    description = "resource_group_name"
}

variable "resource_group_location" {
    description = "resource_group_location"
}

/* variable "tags" {
    description = "tags"
    default = {
        environment = "dev"
    }
} */

#vnet
variable "vnet_name" {
    description = "vnet_name"
}
variable "vnet_address_space" {
    description = "vnet_address_space"
}

#subnet
variable "subnet_name" {
    description = "subnet_name"
}
variable "subnet_address_prefixes" {
    description = "subnet_address_prefixes"
}

#public_ip_address
variable "public_ip_name" {
    description = "public_ip_name"
}
variable "public_ip_allocation_method" {
    description = "public_ip_allocation_method"
}

variable "public_ip_sku" {
    description = "public_ip_sku"
}


/*  
#application_gateway
variable "backend_address_pool_name" {
    description = "backend_address_pool_name"
}
variable "frontend_port_name" {
    description = "frontend_port_name"
}
variable "frontend_ip_configuration_name" {
    description = "frontend_ip_configuration_name"
}
variable "http_setting_name" {
    description = "http_setting_name"
}
variable "listener_name" {
    description = "listener_name"
}
variable "request_routing_rule_name" {
    description = "request_routing_rule_name"
}
variable "redirect_configuration_name" {
    description = "redirect_configuration_name"
}
variable "application_gateway_name" {
    description = "application_gateway_name"
}
variable "sku_name" {
    description = "sku_name"
}
variable "sku_tier" {
    description = "sku_tier"
}

variable "sku_capacity" {
    description = "sku_capacity"
}

variable "gateway_ip_configuration_name" {
    description = "gateway_ip_configuration_name"
}


variable "frontend_port" {
    description = "frontend_port"
}
variable "cookie_based_affinity" {
    description = "cookie_based_affinity"
}
variable "path" {
    description = "path"
}
variable "port" {
    description = "port"
}
variable "protocol" {
    description = "protocol"
}
variable "request_timeout" {
    description = "request_timeout"
}
variable "probe_name" {
    description = "probe_name"
}
variable "interval" {
  description = "interval"
}
variable "timeout" {
  description = "timeout"
}
variable "unhealthy_threshold" {
  description = "unhealthy_threshold"
}
variable "http_listener_protocol" {
    description = "http_listener_protocol"
}
variable "rule_type" {
    description = "rule_type"
} 
 
#waf

 variable "waf_variable" {
    type = map(object({
       waf_name= string
       wafenabled= string
       wafmode= string
       wafcheck= string
       filesize= string
       request_body_size= string
       managed_rule_set_type= string
       managed_rule_set_version= string

    }))
}

variable "managed_rules" {
    type = map(object({
       match_variable= string
       selector= string
       selector_match_operator= string
    }))
}
         
variable "custom_rules" {
    type = map(object({
       name= string
       priority = string
       rule_type = string
       action = string
       operator = string
       negation_condition = string
       match_values = list(string)
       variable_name = string
      
    }))
} 

 */
#appgw

 variable "appgw_variable" {
    type = map(object({
       #name
       application_gateway_name= string
       #sku
       sku_name= string
       sku_tier= string
       sku_capacity= string
       #gw
       gateway_ip_configuration_name= string
      // subnet_id= string
       #frontend port
       frontend_port_name= string
       frontend_port= string
       #frontend_ip
       frontend_ip_configuration_name = string
       
       #backend
       backend_address_pool_name= string
       #behttp
       http_setting_name= string
       cookie_based_affinity= string
       port = string
       path= string
       protocol= string
       request_timeout = string
       #probe
       probe_name= string                
       host      = string            
       interval= string
       timeout= string
       unhealthy_threshold= string
       #listener
       listener_name   = string   
       http_listener_protocol   = string   
       #request
       request_routing_rule_name   = string   
       rule_type   = string   

    }))
}
/*  
 variable "subnet_id" {
    description = "subnet_id"
}

variable "public_ip_id" {
    description = "public_ip_address_id"
}  */

#waf

 variable "waf_variable" {
    type = map(object({
       waf_name= string
       wafenabled= string
       wafmode= string
       wafcheck= string
       filesize= string
       request_body_size= string
       managed_rule_set_type= string
       managed_rule_set_version= string

    }))
}

variable "managed_rules" {
    type = map(object({
       match_variable= string
       selector= string
       selector_match_operator= string
    }))
}
         
variable "custom_rules" {
    type = map(object({
       name= string
       priority = string
       rule_type = string
       action = string
       operator = string
       negation_condition = string
       match_values = list(string)
       variable_name = string
      
    }))
} 