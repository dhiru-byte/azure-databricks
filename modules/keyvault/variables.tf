# General variables
variable "rg_name" {}
variable "location" {}

# Keyvault specific variables
variable "kv_name" {}
variable "kv_disk_encryption" {}
variable "kv_sku_name" {}
variable "tags" {}
variable "kv_purge_protection" {}

# Keyvault Data Factory specific variables
variable "kv_df_ac_object_id" {}
variable "kv_df_ac_tenant_id" {}
variable "kv_df_ac_key_permissions" {}
variable "kv_df_ac_secret_permissions" {}
variable "kv_df_ac_storage_permissions" {}


# Log analytics specific variables
# variable "la_id" {}
variable "la_workspace_id" {}
variable "la_shared_key" {}

# keyvault service principle access policy (Terraform)
variable "kv_sp_ac_key_permissions" {}
variable "kv_sp_ac_secret_permissions" {}
variable "kv_sp_ac_storage_permissions" {}
variable "kv_eds_spdata_ac_object_id" {}

# Secrets for Data Factory Pipeline
variable "dls_accountKey" {}
variable "dls_dfs_endpoint" {}
variable "dls_name" {}
variable "df_name" {}

# Databricks
variable "dbr-workspace-url" {}
/*variable "dbr-cluster-id" {}*/

# Storage Account generic for machine learning workspace
variable "sa_accountKey" {}
variable "sa_name" {}

# Application Insights
variable "ia_name" {}
variable "ia_instrumention_key" {}
variable "ia_connection_string" {}