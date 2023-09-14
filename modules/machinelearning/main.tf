resource "azurerm_machine_learning_workspace" "ml_workspace" {
  application_insights_id = var.ai_id
  key_vault_id            = var.kv_id
  location                = data.azurerm_resource_group.rg-ml.location
  name                    = var.ml_workspace_name
  resource_group_name     = data.azurerm_resource_group.rg-ml.name
  storage_account_id      = var.sa_id
  tags                    = data.azurerm_resource_group.rg-ml.tags
  identity {
    type = var.ml_identity_type
  }
}

# Diagnostic settings for log analytics
#######################################
resource "azurerm_monitor_diagnostic_setting" "ml_diagnostic_settings" {
  name                       = "ml_diagnostic_settings"
  target_resource_id         = azurerm_machine_learning_workspace.ml_workspace.id
  log_analytics_workspace_id = var.la_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.ml_diagnostic_settings.logs
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.ml_diagnostic_settings.metrics
    content {
      category = metric.value
      retention_policy {
        enabled = false
      }
    }
  }
}