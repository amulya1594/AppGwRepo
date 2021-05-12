/* 
#Only waf
module "resource_group" {
  source                  = "./modules/resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "web_application_firewall" {
    source = "./modules/waf"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    waf_variable  = var.waf_variable
    managed_rules = var.managed_rules
    custom_rules = var.custom_rules
    tags            = var.tags
    depends_on      =[module.resource_group]

}
 */
########################

module "resource_group" {
  source                  = "./modules/resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  //tags                    = "${var.tags}"
}

module "vnet" {
  source                  = "./modules/vnet"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  vnet_name               = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  depends_on              = [module.resource_group]
}

module "subnet" {
  source                  = "./modules/subnet"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  subnet_name             = var.subnet_name
  vnet_name               = var.vnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  depends_on              = [module.vnet]
}

module "public_ip_address" {
  source                      = "./modules/public_ip_address"
  public_ip_name              = var.public_ip_name
  resource_group_name         = var.resource_group_name
  resource_group_location     = var.resource_group_location
  public_ip_allocation_method = var.public_ip_allocation_method
  public_ip_sku               = var.public_ip_sku
 // tags                        = var.tags
  depends_on                  = [module.subnet]
}
/*  
module "application_gateway" {
    source                          = "./modules/application_gateway"
    application_gateway_name        = var.application_gateway_name
    resource_group_name             = var.resource_group_name
    resource_group_location         = var.resource_group_location
    
    sku_name                        = var.sku_name
    sku_tier                        = var.sku_tier
    sku_capacity                    = var.sku_capacity
    gateway_ip_configuration_name   = var.gateway_ip_configuration_name
    
    subnet_id                       = module.subnet.subnet_id
    frontend_port_name              = var.frontend_port_name
    frontend_port                   = var.frontend_port
    frontend_ip_configuration_name  = var.frontend_ip_configuration_name
    
    public_ip_id                    = module.public_ip_address.public_ip_id
    
    //waf_name                        = var.waf_name

    backend_address_pool_name       = var.backend_address_pool_name
    http_setting_name               = var.http_setting_name
    listener_name                   = var.listener_name
    request_routing_rule_name       = var.request_routing_rule_name
    redirect_configuration_name     = var.redirect_configuration_name    
    cookie_based_affinity           = var.cookie_based_affinity
    path                            = var.path
    port                            = var.port
    protocol                        = var.protocol
    request_timeout                 = var.request_timeout
    probe_name                      = var.probe_name
    interval                        = var.interval
    timeout                         = var.timeout
    unhealthy_threshold             = var.unhealthy_threshold
    http_listener_protocol          = var.http_listener_protocol
    rule_type                       = var.rule_type
    tags                            = var.tags

    #WAF
    
     waf_variable=var.waf_variable
     custom_rules=var.custom_rules
     managed_rules=var.managed_rules


    depends_on                      = [module.subnet, module.public_ip_address]
}   
 */
 
module "application_gateway" {
    source                          = "./modules/application_gateway"
    
    resource_group_name             = var.resource_group_name
    resource_group_location         = var.resource_group_location
    
    
    #appgw
    subnet_id=module.subnet.subnet_id
    appgw_variable=var.appgw_variable
    public_ip_id=module.public_ip_address.public_ip_id
    #waf
    
     waf_variable=var.waf_variable
     custom_rules=var.custom_rules
     managed_rules=var.managed_rules


    depends_on                      = [module.subnet, module.public_ip_address]
}   