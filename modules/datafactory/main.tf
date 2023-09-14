# Data factory resource
resource "azurerm_data_factory" "df" {
  name                = var.df_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags

  # Specifies the identity type of Data Factory, only allowed value is SystemAssigned.
  identity {
    type = var.df_identity_type
  }
}

# Diagnostic settings for log analytics
#######################################
# resource "azurerm_monitor_diagnostic_setting" "df_diagnostic_settings" {
#   name                           = "df_diagnostic_settings"
#   target_resource_id             = azurerm_data_factory.df.id
#   log_analytics_workspace_id     = var.la_id
#   log_analytics_destination_type = "Dedicated"

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.df_diagnostic_settings.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.df_diagnostic_settings.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }
