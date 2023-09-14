
# Data Lake V2
resource "azurerm_storage_account" "sa_dlv2" {
  name                      = var.dlv2_name
  resource_group_name       = data.azurerm_resource_group.sav2.name
  location                  = data.azurerm_resource_group.sav2.location
  account_tier              = var.dlv2_account_tier
  account_kind              = var.dlv2_account_kind
  account_replication_type  = var.dlv2_account_replication_type
  enable_https_traffic_only = var.dlv2_https_traffic_only
  is_hns_enabled            = var.dlv2_hns_enabled
  tags                      = var.tags

  network_rules {
    default_action = var.dlv2_network_rules_default_action
    // virtual_network_subnet_ids is a list!
    virtual_network_subnet_ids = var.dlv2_virtual_network_subnet_ids
  }
}

# EnterpriseDataServices container
resource "azurerm_storage_data_lake_gen2_filesystem" "enterprisedataservicescontainer" {
  name               = var.dlv2_eds_layer_name
  storage_account_id = azurerm_storage_account.sa_dlv2.id
}

# Workspace container
# resource "azurerm_storage_data_lake_gen2_filesystem" "workspacecontainer" {
#   name               = var.dlv2_workspace_layer
#   storage_account_id = azurerm_storage_account.sa_dlv2.id
# }


# Diagnostic settings for log analytics
#######################################
# DLV2 Logging
# resource "azurerm_monitor_diagnostic_setting" "dlv2_diagnostic_settings" {
#   name                       = "dlv2_diagnostic_settings"
#   target_resource_id         = azurerm_storage_account.sa_dlv2.id
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_diagnostic_categories.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_diagnostic_categories.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }

# # DLV2 Table logging
# resource "azurerm_monitor_diagnostic_setting" "dlv2_table_diagnostic_settings" {
#   name                       = "dlv2_table_diagnostic_settings"
#   target_resource_id         = "${azurerm_storage_account.sa_dlv2.id}/tableServices/default"
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_table_diagnostic_categories.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_table_diagnostic_categories.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }

# # DLV2 Blob logging
# resource "azurerm_monitor_diagnostic_setting" "dlv2_blob_diagnostic_settings" {
#   name                       = "dlv2_blob_diagnostic_settings"
#   target_resource_id         = "${azurerm_storage_account.sa_dlv2.id}/blobServices/default"
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_blob_diagnostic_categories.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.dlv2_blob_diagnostic_categories.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }
