resource_group_name = "my-resource-group"
location            = "eastus"

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
