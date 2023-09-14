resource "azurerm_storage_account" "sy_storage_account" {
  name                     = var.sy_sa_name
  resource_group_name      = data.azurerm_resource_group.sy-rg.name
  location                 = data.azurerm_resource_group.sy-rg.location
  account_tier             = var.sy_account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  is_hns_enabled           = var.is_hns_enabled
}

resource "azurerm_storage_data_lake_gen2_filesystem" "sy_filesystem" {
  name               = var.sy_filesystem_name
  storage_account_id = azurerm_storage_account.sy_storage_account.id
}

resource "azurerm_synapse_workspace" "sy_workspace" {
  name                                 = var.sy_workspace_name
  resource_group_name                  = data.azurerm_resource_group.sy-rg.name
  location                             = data.azurerm_resource_group.sy-rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.sy_filesystem.id
  # sql_administrator_login              = var.sql_administrator_login
  # sql_administrator_login_password     = var.sql_administrator_login_password

  aad_admin {
    login     = "AzureAD Admin"
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id
  }

  identity {
    type = var.sy_identity_type
  }

  tags = var.tags
}

resource "azurerm_synapse_role_assignment" "synapse_role_assignment" {
  synapse_workspace_id = azurerm_synapse_workspace.sy_workspace.id
  role_name            = "Synapse Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
  # depends_on = [azurerm_synapse_firewall_rule.example]
}

resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  name                 = var.sy_sql_pool_name
  synapse_workspace_id = azurerm_synapse_workspace.sy_workspace.id
  sku_name             = "DW100c"
  create_mode          = "Default"
}

# resource "azurerm_key_vault" "sy_keyvault" {
#   name                     = var.sy_kv_name
#   resource_group_name      = data.azurerm_resource_group.synapse.name
#   location                 = data.azurerm_resource_group.synapse.location
#   tenant_id                = data.azurerm_client_config.current.tenant_id
#   sku_name                 = var.sy_sku_name
#   purge_protection_enabled = var.sy_kv_purge_protection
# }

# # Diagnostic settings for log analytics
# resource "azurerm_monitor_diagnostic_setting" "sy_diagnostic_settings" {
#   name                       = "sy_diagnostic_settings"
#   target_resource_id         = azurerm_synapse_workspace.sy_workspace.id
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.sy_diagnostic_categories.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.sy_diagnostic_categories.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }