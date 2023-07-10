resource_group_name = "my-resource-group"
location            = "eastus"

autoscale_settings = [
  {
    name                 = "autoscale-setting-1"
    resource_group_name  = "my-resource-group"
    location             = "East US"
    target_resource_id   = "/subscriptions/subscription-id/resourceGroups/my-resource-group/providers/Microsoft.Compute/virtualMachineScaleSets/my-scale-set"
    cpu_threshold        = 75
    scale_up_value       = 1
    scale_down_value     = 1
    scale_up_cooldown    = "PT5M"
    scale_down_cooldown  = "PT5M"
  },
  {
    name                 = "autoscale-setting-2"
    resource_group_name  = "my-resource-group"
    location             = "West US"
    target_resource_id   = "/subscriptions/subscription-id/resourceGroups/my-resource-group/providers/Microsoft.Compute/virtualMachineScaleSets/my-scale-set"
    cpu_threshold        = 25
    scale_up_value       = 1
    scale_down_value     = 1
    scale_up_cooldown    = "PT5M"
    scale_down_cooldown  = "PT5M"
  }
]

load_balancers = {
  lb1 = {
    name                        = "my-load-balancer-1"
    public_ip                   = "my-public-ip-1"
    lb_rule_frontend_port       = 80
    lb_rule_backend_port        = 8080
    lb_rule_frontend_ip_config  = "PublicIPAddress"
  }
  lb2 = {
    name                        = "my-load-balancer-2"
    public_ip                   = "my-public-ip-2"
    lb_rule_frontend_port       = 80
    lb_rule_backend_port        = 8080
    lb_rule_frontend_ip_config  = "PublicIPAddress"
  }
}
