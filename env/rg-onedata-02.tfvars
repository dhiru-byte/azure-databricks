##### Usually it is sufficient to modify only the variables below for a workspace. #####
deploy_synapse          = false
deploy_appserviceplan   = true

container_registry_name = "crdonedataworkspace02"
service_plan_name       = "asp-d-onedataworkspace-02"
web_app_name            = "wa-d-onedataworkspace-02"

rg_name                 = "rg-d-onedataworkspace-02" # Resouce Groups
dlv2_name               = "dlsonedata02"             # Data Lake V2
df_name                 = "df-onedata-02"            # Data Factory
kv_name                 = "kv-onedata-02"            # Keyvault
dbr_name                = "dbr-onedata-02"           # Databricks
la_name                 = "la-onedata-02"            # Log Analytics
sa_generic_name         = "saonedata02"              # Generic Storage Account. can' have special characters.
ai_name                 = "ais-onedata-02"           # Application insights
dbr_managed_rg_name     = "rg-databricks-02"         # Databricks managed resource group name
df_vsts_repository_name = "df-onedata-02"

#ml_workspace_name       = "mlw-d-onedataworkspace-02"            # Machine Learning workspace
# dbr_sql_user            = ["tp_yadav@nutreco.com"]
# dbr_sql_group           = [""]

##### Synapse
sy_sa_name               = "sasyonedata02"
account_replication_type = "LRS"
account_kind             = "StorageV2"
is_hns_enabled           = "true"
sy_account_tier          = "Standard"
sy_filesystem_name       = "sy-fs-onedata-02"
sy_workspace_name        = "sy-onedata-workspace-02"
sy_identity_type         = "SystemAssigned"
sy_sql_pool_name         = "synapse_sql_pool_02"

#sql_administrator_login          = "Nutreco"
#sql_administrator_login_password = "1data23!"
#sy_keyvault_name            = "sy-kv-onedata-02"
#sy_sku_name                 = "standard"
#sy_kv_purge_protection      = "false"

# Data Factory
df_vsts_account_name = ""
df_vsts_branch_name  = ""
df_vsts_project_name = ""
df_vsts_root_folder  = ""

##### The variables below usually do not need to be adjusted for a workspace. #####
# Data Factory
df_identity_type        = "SystemAssigned"
df_vsts_deployment_mode = "Incremental"

# Data Lake V2
dlv2_account_tier                 = "Standard"
dlv2_account_kind                 = "StorageV2"
dlv2_account_replication_type     = "LRS"
dlv2_https_traffic_only           = true
dlv2_hns_enabled                  = true
dlv2_network_rules_default_action = "Allow"
# dlv2_workspace_layer              = "workspace"
dlv2_eds_layer_name         = "enterprisedataservices"
dlv2_eds_layer_access_type  = "private"
dlv2_role_1_definition_name = "Owner"                         # Data Lake V2 Role one (owner)
dlv2_role_2_definition_name = "Storage Blob Data Contributor" # Data Lake V2 Role two

# Keyvault
kv_disk_encryption  = true
kv_sku_name         = "standard"
kv_purge_protection = true
# keyvault datafactory access policy
kv_df_ac_key_permissions     = ["Get", "List"]
kv_df_ac_secret_permissions  = ["Get", "List", "Set"]
kv_df_ac_storage_permissions = ["Get", "List"]
# keyvault service principle access policy (Terraform)
kv_sp_ac_key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
kv_sp_ac_secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
kv_sp_ac_storage_permissions = ["Get", "List"]
dbr_vn_address_space         = ["10.0.0.0/16"] # Network

# Databricks public subnet
dbr_vnsnpublic_address_prefixes            = ["10.0.0.0/24"]
dbr_vnsnpublic_service_endpoints           = ["Microsoft.Storage"]
dbr_vnsnpublic_service_delegation_name     = "Microsoft.Databricks/workspaces"
dbr_vnsnpublic_service_delegations_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action", ]
# Databricks private subnet
dbr_vnsnprivate_address_prefixes            = ["10.0.1.0/24"]
dbr_vnsnprivate_service_endpoints           = ["Microsoft.Storage"]
dbr_vnsnprivate_service_delegation_name     = "Microsoft.Databricks/workspaces"
dbr_vnsnprivate_service_delegations_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action", ]
dbr_nsg_name                                = "nsg-databricks-02"
dbr_vn_name                                 = "vn-databricks-02"
dbr_vnsnpublic_name                         = "sn-public-02"
dbr_vnsnpublic_delegate_name                = "sn-publicdelegation-02"
dbr_vnsnprivate_name                        = "sn-private-02"
dbr_vnsnprivate_delegate_name               = "sn-privatedelegation-02"
dbr_ws_sku                                  = "premium" # Databricks
# Application
dbr_cluster_name            = "Cluster01"
dbr_autotermination_minutes = 60
dbr_min_workers             = 1
dbr_max_worker              = 2

# Log Analytics
la_solutions = [{ solution_name = "KeyVaultAnalytics", publisher = "Microsoft", product = "OMSGallery/KeyVaultAnalytics", }, { solution_name = "NetworkMonitoring", publisher = "Microsoft", product = "OMSGallery/NetworkMonitoring", }, { solution_name = "Security", publisher = "Microsoft", product = "OMSGallery/Security", }, ]
la_ws_sku    = "PerGB2018"

# Generic parameters
environment_name       = "development"
environment_short_name = "d"
location               = "North Europe"
location_short_name    = "neu"

# Generic tags
tags = {
  "dtap value"         = "DEV"
  "gits servicenumber" = "9611"
}

# ## Service Principal credentials
ARM_SUBSCRIPTION_ID        = "__arm-subscription-id__"
ARM_CLIENT_ID              = "__mds-workspace-sp-appid-02__"
ARM_CLIENT_SECRET          = "__mds-workspace-sp-password-02__"
ARM_TENANT_ID              = "__arm-tenant-id__"
kv_eds_spdata_ac_object_id = "__az-kv-spdata-ac-object-id__"
ARM_OBJECT_ID              = "__mds-workspace-sp-objectid-02__"

# AD group workspace
mds_workspace_admin_identity_id = "__mds-workspace-adgroup-02__"
df_vsts_tenant_id               = "__arm-tenant-id__"

# Giving access to SP
eds_d_sp_objectid = "__sp-d-data-objectid__"
eds_t_sp_objectid = "__sp-t-data-objectid__"
eds_a_sp_objectid = "__sp-a-data-objectid__"
eds_p_sp_objectid = "__sp-p-data-objectid__"

# Application insightsterraform state
ai_application_type   = "other"
ai_retention_in_days  = 90
ai_disable_ip_masking = true

# Machine Learning workspace
# ml_identity_type = "SystemAssigned"

