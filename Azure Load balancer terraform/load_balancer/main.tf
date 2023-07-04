resource "azurerm_public_ip" "public_ip" {
  for_each             = var.load_balancers

  name                 = each.value.public_ip
  location             = var.location
  resource_group_name  = var.resource_group_name
  allocation_method    = "Static"
}

resource "azurerm_lb" "load_balancer" {
  for_each             = var.load_balancers

  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each             = var.load_balancers

  name                 = "BackendPool"
  loadbalancer_id      = azurerm_lb.load_balancer[each.key].id
}

resource "azurerm_lb_rule" "rule" {
  for_each             = var.load_balancers

  name                            = "HTTPRule"
  protocol                        = "Tcp"
  frontend_port                   = each.value.lb_rule_frontend_port
  backend_port                    = each.value.lb_rule_backend_port
  frontend_ip_configuration_name  = each.value.lb_rule_frontend_ip_config
  loadbalancer_id                 = azurerm_lb.load_balancer[each.key].id
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
}
