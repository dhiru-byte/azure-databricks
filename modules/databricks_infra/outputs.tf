
output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.databricks_workspace.workspace_id
}

output "databricks_workspace_url" {
  value = azurerm_databricks_workspace.databricks_workspace.workspace_url
}

output "databricks_resource_id" {
  value = azurerm_databricks_workspace.databricks_workspace.id
}