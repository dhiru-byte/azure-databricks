# Azure resource group information
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# Diagnostic settings for log analytics
#######################################
data "azurerm_monitor_diagnostic_categories" "sa_diagnostic_settings" {
  resource_id = azurerm_storage_account.generic_sa.id
}
