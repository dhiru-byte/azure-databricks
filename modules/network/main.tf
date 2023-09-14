# Databricks needs a virtual network in order to provide access to Azure Storage.
resource "azurerm_network_security_group" "databricks_vnet_security_group" {
  name                = var.dbr_nsg_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  tags                = var.tags
}

resource "azurerm_virtual_network" "databricks_vnet" {
  name                = var.dbr_vn_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  # No clue about Nutreco VNETs, need to talk with Azure owners about it.
  address_space = var.dbr_vn_address_space
  tags          = var.tags
}

resource "azurerm_subnet" "databricks_subnet_public" {
  name                 = var.dbr_vnsnpublic_name
  virtual_network_name = azurerm_virtual_network.databricks_vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name
  address_prefixes     = var.dbr_vnsnpublic_address_prefixes
  service_endpoints    = var.dbr_vnsnpublic_service_endpoints

  delegation {
    name = var.dbr_vnsnpublic_delegate_name
    service_delegation {
      name    = var.dbr_vnsnpublic_service_delegation_name
      actions = var.dbr_vnsnpublic_service_delegations_actions
    }
  }
}

resource "azurerm_subnet" "databricks_subnet_private" {
  name                 = var.dbr_vnsnprivate_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.databricks_vnet.name
  address_prefixes     = var.dbr_vnsnprivate_address_prefixes
  service_endpoints    = var.dbr_vnsnprivate_service_endpoints

  delegation {
    name = var.dbr_vnsnprivate_delegate_name
    service_delegation {
      name    = var.dbr_vnsnprivate_service_delegation_name
      actions = var.dbr_vnsnprivate_service_delegations_actions
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "databricks_subnet_private_ngs_association" {
  network_security_group_id = azurerm_network_security_group.databricks_vnet_security_group.id
  subnet_id                 = azurerm_subnet.databricks_subnet_private.id
}

resource "azurerm_subnet_network_security_group_association" "databricks_subnet_public_ngs_association" {
  network_security_group_id = azurerm_network_security_group.databricks_vnet_security_group.id
  subnet_id                 = azurerm_subnet.databricks_subnet_public.id
}