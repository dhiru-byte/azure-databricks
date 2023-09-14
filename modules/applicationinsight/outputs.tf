// Application insights output
output "ai_name" {
  value = azurerm_application_insights.ai.name
}

output "ai_type" {
  value = azurerm_application_insights.ai.application_type
}

output "ai_disable_ip_masking" {
  value = azurerm_application_insights.ai.disable_ip_masking
}

output "ai_retention_days" {
  value = azurerm_application_insights.ai.retention_in_days
}

output "ai_instrumentation_key" {
  value = azurerm_application_insights.ai.instrumentation_key
}

output "ai_connection_string" {
  value = azurerm_application_insights.ai.connection_string
}

output "ai_id" {
  value = azurerm_application_insights.ai.id
}