resource "azurerm_public_ip" "public_ip" {
  for_each             = var.load_balancers

  name                 = each.value.public_ip
  location             = var.location
  resource_group_name  = var.resource_group_name
  allocation_method    = "Static"
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  count               = length(var.autoscale_settings)
  name                = var.autoscale_settings[count.index].name
  resource_group_name = var.autoscale_settings[count.index].resource_group_name
  target_resource_id   = var.autoscale_settings[count.index].target_resource_id
  location            = var.autoscale_settings[count.index].location

  profile {
    name = "defaultProfile"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.autoscale_settings[count.index].target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.autoscale_settings[count.index].cpu_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = var.autoscale_settings[count.index].scale_up_value
        cooldown  = var.autoscale_settings[count.index].scale_up_cooldown
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.autoscale_settings[count.index].target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale_settings[count.index].cpu_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = var.autoscale_settings[count.index].scale_down_value
        cooldown  = var.autoscale_settings[count.index].scale_down_cooldown
      }
    }
  }
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
