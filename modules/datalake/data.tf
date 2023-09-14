# Resource Group for information
data "azurerm_resource_group" "sav2" {
  name = var.rg_name
}

data "azurerm_virtual_network" "vnet_dbr_2" {
  name                = var.dbr_vn_name
  resource_group_name = data.azurerm_resource_group.sav2.name
}

data "azurerm_subnet" "sav2_dbr_public" {
  name                 = var.dbr_vnsnpublic_name
  resource_group_name  = data.azurerm_resource_group.sav2.name
  virtual_network_name = data.azurerm_virtual_network.vnet_dbr_2.name
}

data "azurerm_subnet" "sav2_dbr_private" {
  name                 = var.dbr_vnsnprivate_name
  resource_group_name  = data.azurerm_resource_group.sav2.name
  virtual_network_name = data.azurerm_virtual_network.vnet_dbr_2.name
}


data "azurerm_monitor_diagnostic_categories" "dlv2_diagnostic_categories" {
  resource_id = azurerm_storage_account.sa_dlv2.id
}

# DLV2 Table logging
data "azurerm_monitor_diagnostic_categories" "dlv2_table_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.sa_dlv2.id}/tableServices/default"
}

# DLV2 Blob logging
data "azurerm_monitor_diagnostic_categories" "dlv2_blob_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.sa_dlv2.id}/blobServices/default"
}