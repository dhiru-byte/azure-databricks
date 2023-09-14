// Application insight resource
resource "azurerm_application_insights" "ai" {
  application_type    = var.ai_application_type
  location            = data.azurerm_resource_group.ai.location
  name                = var.ai_name
  retention_in_days   = var.ai_retention_in_days
  disable_ip_masking  = var.ai_disable_ip_masking
  resource_group_name = data.azurerm_resource_group.ai.name
  tags                = data.azurerm_resource_group.ai.tags
}