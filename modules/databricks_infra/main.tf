# databricks
resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                        = var.dbr_ws_name
  resource_group_name         = data.azurerm_resource_group.main.name
  location                    = var.location
  sku                         = var.dbr_ws_sku
  tags                        = var.tags
  managed_resource_group_name = var.dbr_managed_rg_name

  custom_parameters {
    virtual_network_id                                   = var.dbr_vn_id
    public_subnet_name                                   = data.azurerm_subnet.public_subnet_dbr.name
    public_subnet_network_security_group_association_id  = data.azurerm_subnet.public_subnet_dbr.network_security_group_id
    private_subnet_name                                  = data.azurerm_subnet.private_subnet_dbr.name
    private_subnet_network_security_group_association_id = data.azurerm_subnet.private_subnet_dbr.network_security_group_id
    #machine_learning_workspace_id                        = var.ml_workspace_id
  }
}