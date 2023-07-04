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
