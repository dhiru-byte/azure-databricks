resource "azurerm_container_registry" "container_registry" {
  name                = var.container_registry_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  # P1V3 is the cheapest available option for a service plan that supports docker webapps.
  sku_name = "P1v3"
}


# for the web app to be for containers we need the registry to have atleast one container which we can use to provision the web app.
# in the quickstart for the registry in the azure portal it shows you how to push a default image a good image that always works is "nginx/hello"
resource "azurerm_linux_web_app" "web_app" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    container_registry_use_managed_identity = true
    application_stack {
      docker_image     = "crdonedataworkspace01.azurecr.io/hello-world"
      docker_image_tag = "latest"
    }
  }

  depends_on = [
    azurerm_container_registry.container_registry
  ]

  lifecycle {
    ignore_changes = [
      app_settings,
      site_config
    ]
  }
}

# access
resource "azurerm_role_assignment" "role_datalake" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_web_app.web_app.identity[0].principal_id
}

resource "azurerm_role_assignment" "role_acr" {
  scope                = azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.web_app.identity[0].principal_id
}

#####  Diagnostic settings for log analytics
resource "azurerm_monitor_diagnostic_setting" "registry_diagnostic_settings" {
  name                           = "registry_diagnostic_settings"
  target_resource_id             = azurerm_container_registry.container_registry.id
  log_analytics_workspace_id     = var.la_id
  log_analytics_destination_type = "Dedicated"

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.registry_diagnostic_settings.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.registry_diagnostic_settings.metrics
    content {
      category = metric.value
      retention_policy {
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "service_plan_diagnostic_settings" {
  name                           = "service_plan_diagnostic_settings"
  target_resource_id             = azurerm_service_plan.service_plan.id
  log_analytics_workspace_id     = var.la_id
  log_analytics_destination_type = "Dedicated"

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.service_plan_diagnostic_settings.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.service_plan_diagnostic_settings.metrics
    content {
      category = metric.value
      retention_policy {
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "web_app_diagnostic_settings" {
  name                           = "web_app_diagnostic_settings"
  target_resource_id             = azurerm_linux_web_app.web_app.id
  log_analytics_workspace_id     = var.la_id
  log_analytics_destination_type = "Dedicated"

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.web_app_diagnostic_settings.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.web_app_diagnostic_settings.metrics
    content {
      category = metric.value
      retention_policy {
        enabled = false
      }
    }
  }
}

