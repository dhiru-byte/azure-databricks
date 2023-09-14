data "azurerm_resource_group" "sy-rg" {
  name = var.rg_name
}

data "azurerm_client_config" "current" {}

# Diagnostic settings for log analytics
data "azurerm_monitor_diagnostic_categories" "sy_diagnostic_categories" {
  resource_id = azurerm_synapse_workspace.sy_workspace.id
}