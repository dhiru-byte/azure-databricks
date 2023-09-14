# Azure resource group information
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# Diagnostic settings for log analytics
#######################################
data "azurerm_monitor_diagnostic_categories" "df_diagnostic_settings" {
  resource_id = azurerm_data_factory.df.id
}