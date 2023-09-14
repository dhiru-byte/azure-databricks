# Get Resource group information
data "azurerm_resource_group" "rg-ml" {
  name = var.rg_name
}

# Diagnostic settings for log analytics
#######################################
data "azurerm_monitor_diagnostic_categories" "ml_diagnostic_settings" {
  resource_id = azurerm_machine_learning_workspace.ml_workspace.id
}
