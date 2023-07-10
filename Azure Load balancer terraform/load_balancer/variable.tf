variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "load_balancers" {
  description = "Map of load balancer configurations"
  type        = map(object({
    name               = string
    public_ip          = string
    lb_rule_frontend_port      = number
    lb_rule_backend_port       = number
    lb_rule_frontend_ip_config = string
  }))
}

variable "autoscale_settings" {
  description = "Autoscaling settings for Azure Load Balancer"
  type        = list(object({
    name                = string
    resource_group_name = string
    location            = string
    target_resource_id  = string
    cpu_threshold       = number
    scale_up_value      = number
    scale_down_value    = number
    scale_up_cooldown   = string
    scale_down_cooldown = string
  }))
}
