output "dbs_vnet_name" {
  value = azurerm_virtual_network.databricks_vnet.name
}

output "dbs_vnet_id" {
  value = azurerm_virtual_network.databricks_vnet.id
}

output "dbs_subnet_private_id" {
  value = azurerm_subnet.databricks_subnet_private.id
}

output "dbs_subnet_public_id" {
  value = azurerm_subnet.databricks_subnet_public.id
}

output "dbs_vnet_subnet_public_name" {
  value = azurerm_subnet.databricks_subnet_public.name
}

output "dbs_vnet_subnet_private_name" {
  value = azurerm_subnet.databricks_subnet_private.name
}

output "dbs_nsg_name" {
  value = azurerm_network_security_group.databricks_vnet_security_group.name
}

