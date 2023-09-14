##### Virtualnetworks and other network related components. ##### Currently only used by databricks.
module "network" {
  source = "./modules/network"
  # source               = "git::https://$(System.AccessToken)@dev.azure.com/nutreco-global/Nutreco%20Data%20Mesh/_git/azure-terraform-modules.git"
  rg_name              = var.rg_name
  location             = var.location
  tags                 = var.tags
  dbr_nsg_name         = var.dbr_nsg_name # Networks security group
  dbr_vn_name          = var.dbr_vn_name  # Databricks vnet
  dbr_vn_address_space = var.dbr_vn_address_space
  ##### Databricks public subnet
  dbr_vnsnpublic_name                        = var.dbr_vnsnpublic_name
  dbr_vnsnpublic_address_prefixes            = var.dbr_vnsnpublic_address_prefixes # copied from original, need to talk with nutreco network team
  dbr_vnsnpublic_service_endpoints           = var.dbr_vnsnpublic_service_endpoints
  dbr_vnsnpublic_delegate_name               = var.dbr_vnsnpublic_delegate_name
  dbr_vnsnpublic_service_delegation_name     = var.dbr_vnsnpublic_service_delegation_name
  dbr_vnsnpublic_service_delegations_actions = var.dbr_vnsnpublic_service_delegations_actions
  ##### Databricks private subnet
  dbr_vnsnprivate_name                        = var.dbr_vnsnprivate_name
  dbr_vnsnprivate_address_prefixes            = var.dbr_vnsnprivate_address_prefixes
  dbr_vnsnprivate_service_endpoints           = var.dbr_vnsnprivate_service_endpoints
  dbr_vnsnprivate_delegate_name               = var.dbr_vnsnprivate_delegate_name
  dbr_vnsnprivate_service_delegation_name     = var.dbr_vnsnprivate_service_delegation_name
  dbr_vnsnprivate_service_delegations_actions = var.dbr_vnsnprivate_service_delegations_actions
}

##### Log analytics workspace for Data Mesh infrastructure
module "loganalytics" {
  source                       = "./modules/loganalytics"
  name                         = var.la_name
  rg_name                      = data.azurerm_resource_group.rg.name
  location                     = var.location
  la_ws_sku                    = var.la_ws_sku
  security_center_subscription = []
  solutions                    = var.la_solutions
  contributors                 = []
  tags                         = var.tags
}

##### Appliation insights
module "ai" {
  source                = "./modules/applicationinsight"
  ai_application_type   = var.ai_application_type
  ai_disable_ip_masking = var.ai_disable_ip_masking
  ai_name               = var.ai_name
  ai_retention_in_days  = var.ai_retention_in_days
  rg_name               = data.azurerm_resource_group.rg.name
}

##### Keyvault deployment
module "keyvault" {
  source              = "./modules/keyvault"
  rg_name             = data.azurerm_resource_group.rg.name
  location            = var.location
  kv_name             = var.kv_name
  kv_disk_encryption  = var.kv_disk_encryption
  kv_sku_name         = var.kv_sku_name
  kv_purge_protection = var.kv_purge_protection
  tags                = var.tags

  ##### Service principle access policy (terraform)
  kv_eds_spdata_ac_object_id   = var.kv_eds_spdata_ac_object_id
  kv_sp_ac_key_permissions     = var.kv_sp_ac_key_permissions
  kv_sp_ac_secret_permissions  = var.kv_sp_ac_secret_permissions
  kv_sp_ac_storage_permissions = var.kv_sp_ac_storage_permissions

  ##### Data factory access policy
  kv_df_ac_object_id           = module.datafactory.df_principal_id
  kv_df_ac_tenant_id           = module.datafactory.df_tenant_id
  kv_df_ac_key_permissions     = var.kv_df_ac_key_permissions
  kv_df_ac_secret_permissions  = var.kv_df_ac_secret_permissions
  kv_df_ac_storage_permissions = var.kv_df_ac_storage_permissions

  ##### Log analytics
  # la_id           = module.loganalytics.resource_id
  la_workspace_id = module.loganalytics.workspace_id
  la_shared_key   = module.loganalytics.shared_key

  ##### Databricks
  dbr-workspace-url = module.databricks_infra.databricks_workspace_url
  #dbr-cluster-id    = module.databricks_application.databricks-cluster-id

  ##### Secrets for Data Factory pipeline
  dls_accountKey   = module.datalakev2.dls_accountKey
  dls_dfs_endpoint = module.datalakev2.dls_dfs_endpoint
  dls_name         = module.datalakev2.dls_name
  df_name          = module.datafactory.df_name

  ##### Storage Account generic for machine learning workspace
  sa_accountKey = module.generic_storage_account.generic_sa_access_key
  sa_name       = module.generic_storage_account.generic_sa_name

  ##### Application Insights
  ia_connection_string = module.ai.ai_connection_string
  ia_instrumention_key = module.ai.ai_instrumentation_key
  ia_name              = module.ai.ai_name
}

# ##### Data Lake v2 with accounts
module "datalakev2" {
  source                            = "./modules/datalake"
  rg_name                           = data.azurerm_resource_group.rg.name
  location                          = var.location
  dlv2_name                         = var.dlv2_name
  dlv2_account_tier                 = var.dlv2_account_tier
  dlv2_account_kind                 = var.dlv2_account_kind
  dlv2_account_replication_type     = var.dlv2_account_replication_type
  dlv2_https_traffic_only           = var.dlv2_https_traffic_only
  dlv2_hns_enabled                  = var.dlv2_hns_enabled
  dlv2_network_rules_default_action = var.dlv2_network_rules_default_action
  tags                              = var.tags

  ##### enterprisedataservices container
  dlv2_eds_layer_name = var.dlv2_eds_layer_name
  # dlv2_eds_layer_access  = var.dlv2_eds_layer_access
  workspace_principal_id = var.ARM_CLIENT_ID

  ##### workspace container
  # dlv2_workspace_layer        = var.dlv2_workspace_layer
  dlv2_role_1_definition_name = var.dlv2_role_1_definition_name
  dlv2_role_1_principal_id    = var.ARM_TENANT_ID
  dlv2_role_2_definition_name = var.dlv2_role_2_definition_name
  dlv2_role_2_principal_id    = var.ARM_TENANT_ID
  la_id                       = module.loganalytics.resource_id

  ##### VNET settings
  dbr_vn_name                     = module.network.dbs_vnet_name
  dlv2_virtual_network_subnet_ids = [module.network.dbs_subnet_private_id, module.network.dbs_subnet_public_id]

  ##### Private subnet databricks
  dbr_vnsnprivate_name = module.network.dbs_vnet_subnet_private_name
  ##### Public subnet databricks
  dbr_vnsnpublic_name = module.network.dbs_vnet_subnet_public_name

  ##### Terraform doesn't see implicit dependency, making it explicit
  depends_on = [module.network]
}

##### Databricks workspace with Azure infrastructure settings, all settings related to databricks are in the databricks_application.
module "databricks_infra" {
  source   = "./modules/databricks_infra"
  rg_name  = data.azurerm_resource_group.rg.name
  location = var.location
  tags     = var.tags
  # ml_workspace_id = module.ml_workspace.machine_learning_workspace_id

  ##### vnet dbr==dbs data bricks
  dbr_vn_name = module.network.dbs_vnet_name
  dbr_vn_id   = module.network.dbs_vnet_id

  ##### private subnet
  dbr_vnsnprivate_name = module.network.dbs_vnet_subnet_private_name
  ##### public subnet
  dbr_vnsnpublic_name = module.network.dbs_vnet_subnet_public_name
  dbr_ws_name         = var.dbr_name
  dbr_ws_sku          = var.dbr_ws_sku
  dbr_managed_rg_name = var.dbr_managed_rg_name

  ##### Terraform doesn't see implicit dependency, making it explicit
  depends_on = [module.network]
}

##### All settings for Databricks itself like clusters, secret scopes and more
module "databricks_application" {
  source                      = "./modules/databricks_application"
  dbr_workspace_id            = module.databricks_infra.databricks_workspace_id
  dbr_cluster_name            = var.dbr_cluster_name
  dbr_autotermination_minutes = var.dbr_autotermination_minutes
  dbr_min_workers             = var.dbr_min_workers
  dbr_max_worker              = var.dbr_max_worker
  dlv2_name                   = module.datalakev2.dls_name
  dlv2_eds_layer_name         = var.dlv2_eds_layer_name
  # dlv2_workspace_layer        = var.dlv2_workspace_layer
  ARM_CLIENT_ID     = var.ARM_CLIENT_ID
  ARM_TENANT_ID     = var.ARM_TENANT_ID
  ARM_CLIENT_SECRET = var.ARM_CLIENT_SECRET
  # dbr_sql_user                = var.dbr_sql_user
  # dbr_sql_group               = var.dbr_sql_group

  ##### Terraform doesn't see implicit dependency, making it explicit
  depends_on = [module.databricks_infra]
}

##### Data Factory
module "datafactory" {
  source   = "./modules/datafactory"
  rg_name  = data.azurerm_resource_group.rg.name
  location = var.location
  tags     = var.tags
  ##### Azure repo configuration
  df_name                 = var.df_name
  df_identity_type        = var.df_identity_type
  df_vsts_account_name    = var.df_vsts_account_name
  df_vsts_branch_name     = var.df_vsts_branch_name
  df_vsts_project_name    = var.df_vsts_project_name
  df_vsts_repository_name = var.df_vsts_repository_name
  df_vsts_root_folder     = var.df_vsts_root_folder
  df_vsts_tenant_id       = var.ARM_TENANT_ID
  df_vsts_deployment_mode = var.df_vsts_deployment_mode
  # la_id                   = module.loganalytics.resource_id
  environment_name = var.environment_name
}

##### ML workspace
# module "ml_workspace" {
#   source            = "./modules/machinelearning"
#   kv_id             = module.keyvault.keyvault_id
#   ml_workspace_name = var.ml_workspace_name
#   rg_name           = data.azurerm_resource_group.rg.name
#   sa_id             = module.generic_storage_account.sa_id
#   la_id             = module.loganalytics.resource_id
#   ai_id             = module.ai.ai_id
#   ml_identity_type  = var.ml_identity_type
# }

##### Authorization deployment, assigning roles to services and service principles.
module "authorization" {
  source                          = "./modules/authorization"
  rg_name                         = data.azurerm_resource_group.rg.name
  dbr_scope_id                    = module.databricks_infra.databricks_resource_id
  df_scope_id                     = module.datafactory.df_id
  dls_scope_id                    = module.datalakev2.dls_id
  mds_workspace_admin_identity_id = var.mds_workspace_admin_identity_id
  workspace_sp_access             = var.ARM_OBJECT_ID

  ##### One Data SPs
  eds_d_sp_objectid = var.eds_d_sp_objectid
  eds_t_sp_objectid = var.eds_t_sp_objectid
  eds_a_sp_objectid = var.eds_a_sp_objectid
  eds_p_sp_objectid = var.eds_p_sp_objectid
}

##### Storage Account
module "generic_storage_account" {
  source  = "./modules/storage_account"
  rg_name = data.azurerm_resource_group.rg.name
  # la_id           = module.loganalytics.resource_id
  sa_generic_name = var.sa_generic_name
}

##### Synapse
module "synapse" {
  count    = var.deploy_synapse == true ? 1 : 0
  source   = "./modules/synapse"
  rg_name  = data.azurerm_resource_group.rg.name
  location = var.location
  # la_id                    = module.loganalytics.resource_id
  sy_account_tier          = var.sy_account_tier
  sy_workspace_name        = var.sy_workspace_name
  sy_identity_type         = var.sy_identity_type
  sy_filesystem_name       = var.sy_filesystem_name
  sy_sa_name               = var.sy_sa_name
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  is_hns_enabled           = var.is_hns_enabled
  sy_sql_pool_name         = var.sy_sql_pool_name
  tags                     = var.tags

  # arm_object_id                    = var.ARM_OBJECT_ID
  # arm_tenant_id                    = var.ARM_TENANT_ID
  # sql_administrator_login          = var.sql_administrator_login
  # sql_administrator_login_password = var.sql_administrator_login_password
  # sy_keyvault_name                 = var.sy_keyvault_name
  # sy_kv_purge_protection           = var.sy_kv_purge_protection
  # sy_sku_name                      = var.sy_sku_name
}

##### AppServicePlan
module "app_service_plan" {
  count                   = var.deploy_appserviceplan == true ? 1 : 0
  source                  = "./modules/appserviceplan"
  rg_name                 = data.azurerm_resource_group.rg.name
  la_id                   = module.loganalytics.resource_id
  container_registry_name = var.container_registry_name
  service_plan_name       = var.service_plan_name
  web_app_name            = var.web_app_name

  # dls_scope_id = module.app_service_plan.resource_id
}