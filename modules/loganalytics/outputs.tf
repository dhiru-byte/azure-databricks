output "resource_id" {
  description = "Id of Log Analytics resource in Azure."
  value       = azurerm_log_analytics_workspace.logs.id
}

output "workspace_id" {
  description = "Log Analytics Workspace id, this is just a guid."
  value       = azurerm_log_analytics_workspace.logs.workspace_id
}

output "shared_key" {
  description = "Log Analytics Workspace shared key"
  value       = azurerm_log_analytics_workspace.logs.primary_shared_key
}

output "la_name" {
  description = "Name of log analytics"
  value       = azurerm_log_analytics_workspace.logs.name
}