output "vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "keyvault_name" {
  value = azurerm_key_vault.kv.name
}
