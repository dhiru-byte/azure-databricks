# Get Resource group information
data "azurerm_resource_group" "rg-kv" {
  name = var.rg_name
}

# Get session information like tenant_id
data "azurerm_client_config" "current" {}

# Diagnostic settings for log analytics
data "azurerm_monitor_diagnostic_categories" "kv_diagnostic_categories" {
  resource_id = azurerm_key_vault.kv.id
}