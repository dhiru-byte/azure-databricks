data "azurerm_resource_group" "main" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet_dbr" {
  name                = var.dbr_vn_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "public_subnet_dbr" {
  name                 = var.dbr_vnsnpublic_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.vnet_dbr.name
}

data "azurerm_subnet" "private_subnet_dbr" {
  name                 = var.dbr_vnsnprivate_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.vnet_dbr.name
}
