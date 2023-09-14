data "azurerm_resource_group" "rg" {
  name = var.rg_name
}


data "azurerm_monitor_diagnostic_categories" "registry_diagnostic_settings" {
  resource_id = azurerm_container_registry.container_registry.id
}

data "azurerm_monitor_diagnostic_categories" "service_plan_diagnostic_settings" {
  resource_id = azurerm_service_plan.service_plan.id
}

data "azurerm_monitor_diagnostic_categories" "web_app_diagnostic_settings" {
  resource_id = azurerm_linux_web_app.web_app.id
}