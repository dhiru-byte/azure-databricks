output "df_name" {
  value = azurerm_data_factory.df.name
}

output "df_principal_id" {
  value = azurerm_data_factory.df.identity[0].principal_id
}

output "df_tenant_id" {
  value = azurerm_data_factory.df.identity[0].tenant_id
}

output "df_id" {
  value = azurerm_data_factory.df.id
}