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

