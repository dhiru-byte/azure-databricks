# Create Keyvault
resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  resource_group_name         = var.rg_name
  location                    = var.location
  enabled_for_disk_encryption = var.kv_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.kv_sku_name
  purge_protection_enabled    = var.kv_purge_protection
  tags                        = var.tags
}

# Access Policies
# ===============
# Service principle access policy (Terraform)
resource "azurerm_key_vault_access_policy" "sp-terraform" {
  key_vault_id        = azurerm_key_vault.kv.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  key_permissions     = var.kv_sp_ac_key_permissions
  secret_permissions  = var.kv_sp_ac_secret_permissions
  storage_permissions = var.kv_sp_ac_storage_permissions
  object_id           = var.kv_eds_spdata_ac_object_id
}

# Data factory access policy, variable prefix is kv_df_ac_{name var}
# This means keyvault_datafactory_accesspolicy_{name var}
resource "azurerm_key_vault_access_policy" "data_factory" {
  key_vault_id = azurerm_key_vault.kv.id
  object_id    = var.kv_df_ac_object_id
  tenant_id    = var.kv_df_ac_tenant_id

  // Following variables are lists (with strings)
  key_permissions     = var.kv_df_ac_key_permissions
  secret_permissions  = var.kv_df_ac_secret_permissions
  storage_permissions = var.kv_df_ac_storage_permissions
}

# Add Log analytics workspace ID to KV
resource "azurerm_key_vault_secret" "la_workspace_id" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "la-workspace-id"
  value        = var.la_workspace_id
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

# Add Log analytics shared key to KV
resource "azurerm_key_vault_secret" "la_shared_key" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "la-shared-key"
  value        = var.la_shared_key
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

# Variables used by Data Factory pipeline
# =======================================
resource "azurerm_key_vault_secret" "dls_name" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "dls-name"
  value        = var.dls_name
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

resource "azurerm_key_vault_secret" "dls_accountKey" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "dls-accountKey"
  value        = var.dls_accountKey
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

resource "azurerm_key_vault_secret" "dls_dfs_endpoint" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "dls-dfs-endpoint"
  value        = var.dls_dfs_endpoint
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}


# Databricks
resource "azurerm_key_vault_secret" "dbr-workspace-url" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "dbr-workspace-url"
  value        = var.dbr-workspace-url
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}


/*resource "azurerm_key_vault_secret" "dbr-cluster-id" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "dbr-cluster-id"
  value        = var.dbr-cluster-id
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}
*/
resource "azurerm_key_vault_secret" "sa-accountkey" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sa-accountKey"
  value        = var.sa_accountKey
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

resource "azurerm_key_vault_secret" "sa-name" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sa-name"
  value        = var.sa_name
  depends_on   = [azurerm_key_vault_access_policy.sp-terraform]
}

# Diagnostic settings for log analytics
# resource "azurerm_monitor_diagnostic_setting" "kv_diagnostic_settings" {
#   name                       = "kv_diagnostic_settings"
#   target_resource_id         = azurerm_key_vault.kv.id
#   log_analytics_workspace_id = var.la_id

#   dynamic "log" {
#     for_each = data.azurerm_monitor_diagnostic_categories.kv_diagnostic_categories.logs
#     content {
#       category = log.value
#       enabled  = true
#       retention_policy {
#         enabled = false
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = data.azurerm_monitor_diagnostic_categories.kv_diagnostic_categories.metrics
#     content {
#       category = metric.value
#       retention_policy {
#         enabled = false
#       }
#     }
#   }
# }
