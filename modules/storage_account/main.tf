# resource "random_id" "storage_account" {
#   byte_length = 8
# }

# Generic storage account for platform files/data
resource "azurerm_storage_account" "generic_sa" {
  name                     = var.sa_generic_name
  location                 = data.azurerm_resource_group.rg.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  resource_group_name      = data.azurerm_resource_group.rg.name
  tags                     = data.azurerm_resource_group.rg.tags
}

# Diagnostic settings for log analytics
#######################################
# resource "azurerm_monitor_diagnostic_setting" "sa_diagnostic_settings" {
#   name                       = "sa_diagnostic_settings"
#   target_resource_id         = azurerm_storage_account.generic_sa.id
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.sa_diagnostic_settings.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.sa_diagnostic_settings.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }
