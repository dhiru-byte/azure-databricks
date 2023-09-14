output "dls_id" {
  value = azurerm_storage_account.sa_dlv2.id
}

output "dls_accountKey" {
  value = azurerm_storage_account.sa_dlv2.primary_access_key
}

output "dls_dfs_endpoint" {
  value = azurerm_storage_account.sa_dlv2.primary_dfs_endpoint
}

output "dls_name" {
  value = azurerm_storage_account.sa_dlv2.name
}