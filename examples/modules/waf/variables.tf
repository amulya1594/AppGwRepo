
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created"
  default     = "myRG"
}

variable "resource_group_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

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
