module "ha_availability_zones" {
  source = "../../ha_availability_zones"

  location            = var.location
  resource_group_name = var.resource_group_name

  virtual_network_address_space    = var.virtual_network_address_space
  management_subnet_address_prefix = var.management_subnet_address_prefix
  client_subnet_address_prefix     = var.client_subnet_address_prefix
  server_subnet_address_prefix     = var.server_subnet_address_prefix

  adc_admin_password = var.adc_admin_password

  controlling_subnet = var.controlling_subnet
}

module "simple_lb_ha" {
  source = "../../simple_lb_ha"

  location            = var.location
  resource_group_name = var.resource_group_name

  management_subnet_id = module.ha_availability_zones.management_subnet_id
  server_subnet_id     = module.ha_availability_zones.server_subnet_id

  private_vips = module.ha_availability_zones.private_vips
  nsips        = module.ha_availability_zones.public_nsips

  adc_admin_password    = var.adc_admin_password
  alb_public_ip         = module.ha_availability_zones.alb_public_ip
  ha_primary_node_index = var.ha_primary_node_index
}
