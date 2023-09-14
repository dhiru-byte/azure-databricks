# reader role for workspace
resource "azurerm_role_assignment" "rg_reader_role" {
  principal_id         = var.mds_workspace_admin_identity_id
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "dls_contributer_role_for_sp" {
  principal_id         = var.workspace_sp_access
  scope                = var.dls_scope_id
  role_definition_name = "Storage Blob Data Contributor"
}

# Contributor role on data factory
resource "azurerm_role_assignment" "df_contributor_role" {
  principal_id         = var.mds_workspace_admin_identity_id
  scope                = var.df_scope_id
  role_definition_name = "Data Factory Contributor"
}

# Contributor role on data factory
resource "azurerm_role_assignment" "dbr_contributor_role" {
  principal_id         = var.mds_workspace_admin_identity_id
  scope                = var.dbr_scope_id
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "dls_contributer_eds_sp_d" {
  principal_id         = var.eds_d_sp_objectid
  scope                = var.dls_scope_id
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "dls_contributer_eds_sp_t" {
  principal_id         = var.eds_t_sp_objectid
  scope                = var.dls_scope_id
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "dls_contributer_eds_sp_a" {
  principal_id         = var.eds_a_sp_objectid
  scope                = var.dls_scope_id
  role_definition_name = "Storage Blob Data Contributor"
}

resource "azurerm_role_assignment" "dls_contributer_eds_sp_p" {
  principal_id         = var.eds_p_sp_objectid
  scope                = var.dls_scope_id
  role_definition_name = "Storage Blob Data Contributor"
}