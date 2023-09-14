output "generic_sa_name" {
  value = azurerm_storage_account.generic_sa.name
}

output "generic_sa_access_key" {
  value = azurerm_storage_account.generic_sa.primary_access_key
}

output "sa_id" {
  value = azurerm_storage_account.generic_sa.id
}