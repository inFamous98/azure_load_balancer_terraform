module "load_balancer" {
  source              = "./load_balancer"
  resource_group_name = var.resource_group_name
  location            = var.location
  load_balancers      = var.load_balancers
  autoscale_settings = var.autoscale_settings
}