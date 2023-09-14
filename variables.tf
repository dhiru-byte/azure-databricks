##### Generic
variable "rg_name" {
  description = "Resource Group name. Example: rg-d-mdsworkspace-01"
}
variable "environment_name" {
  description = "Environment name: development, test, acceptance or production"
  default     = "development"
}
variable "environment_short_name" {
  description = "environment short name: d, t, a, or p"
  default     = "d"
}
variable "location" {
  description = "Azure region: North Europe"
  default     = "West Europe"
}
variable "location_short_name" {
  description = "Location short name: neu"
  default     = "weu"
}

variable "tags" {
  description = "Default tags for every Azure resource"
}

variable "sa_generic_name" {
  description = "Generic storage account"
}

##### Enterprise Data Services
variable "eds_d_sp_objectid" {
  type        = string
  description = "id of service principal of sp eds dev"
}
variable "eds_t_sp_objectid" {
  type        = string
  description = "id of service principal of sp eds test"
}
variable "eds_a_sp_objectid" {
  type        = string
  description = "id of service principal of sp eds acc"
}
variable "eds_p_sp_objectid" {
  type        = string
  description = "id of service principal of sp eds prod"
}

##### provider.tf
variable "ARM_SUBSCRIPTION_ID" {
  description = "Subscription ID."
}
variable "ARM_CLIENT_ID" {
  description = "See AAD, App registration, sp-terraform: Application (client) ID"
}
variable "ARM_CLIENT_SECRET" {
  description = "See AAD, App registration, sp-terraform, Client Secret. Use the value"
}
variable "ARM_TENANT_ID" {
  description = "Tenant ID. See Azure Active Directory"
}
variable "ARM_OBJECT_ID" {
  description = "Object ID of mds sp"
}

##### network.tf
variable "dbr_nsg_name" {
  description = "Network Security Group for Databricks vnet"
}
variable "dbr_vn_name" {
  description = "Virtual network name for databricks network"
}
variable "dbr_vnsnpublic_name" {
  description = "Public subnet name for databricks network"
}
variable "dbr_vnsnpublic_delegate_name" {}
variable "dbr_vnsnprivate_name" {
  description = "Private subnet name for databricks network"
}
variable "dbr_vnsnprivate_delegate_name" {}
variable "dbr_vn_address_space" {
  description = "Address space for databricks network in CIDR-format. Should be a /16 network"
}
variable "dbr_vnsnpublic_address_prefixes" {
  description = "Address space for public subnet databricks in CIDR-format. Should be a /24 network"
}
variable "dbr_vnsnpublic_service_endpoints" {}
variable "dbr_vnsnpublic_service_delegation_name" {}
variable "dbr_vnsnpublic_service_delegations_actions" {}
variable "dbr_vnsnprivate_address_prefixes" {
  description = "Address space for private subnet databricks in CIDR-format. Should be a /24 network"
}
variable "dbr_vnsnprivate_service_endpoints" {}
variable "dbr_vnsnprivate_service_delegation_name" {}
variable "dbr_vnsnprivate_service_delegations_actions" {}

##### log_analytics.tf
variable "la_name" {
  description = "Log Analytics workspace name. Should be global unique"
}
variable "la_solutions" {
  description = "A list of solutions to add to the workspace. Should contain solution_name, publisher and product."
  type        = list(object({ solution_name = string, publisher = string, product = string }))
  default     = []
}
variable "la_ws_sku" {
  description = "Specified the Sku of the Log Analytics Workspace."
  type        = string
}

##### application_insights.tf
variable "ai_application_type" {
  description = "Specifies the type of Application Insights to create. Valid values: ios, java, MobileCenter, Node.js, other, phone, store, web"
  type        = string
}
variable "ai_disable_ip_masking" {
  description = "By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. Defaults to false."
}
variable "ai_name" {
  description = "Specifies the name of the Application Insights component. Changing this forces a new resource to be created."
}
variable "ai_retention_in_days" {
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}

##### keyvault.tf
variable "kv_name" {}
variable "kv_disk_encryption" {}
variable "kv_sku_name" {}
variable "kv_purge_protection" {}
variable "kv_df_ac_key_permissions" {}
variable "kv_df_ac_secret_permissions" {}
variable "kv_df_ac_storage_permissions" {}
##### keyvault service principle access policy (Terraform)
variable "kv_sp_ac_key_permissions" {}
variable "kv_sp_ac_secret_permissions" {}
variable "kv_sp_ac_storage_permissions" {}
variable "kv_eds_spdata_ac_object_id" {}

##### data_lake.tf
variable "dlv2_name" {}
variable "dlv2_account_tier" {}
variable "dlv2_account_kind" {}
variable "dlv2_account_replication_type" {}
variable "dlv2_https_traffic_only" {}
variable "dlv2_hns_enabled" {}
variable "dlv2_network_rules_default_action" {}
variable "dlv2_role_1_definition_name" {}
variable "dlv2_role_2_definition_name" {}
variable "dlv2_eds_layer_name" {}
variable "dlv2_eds_layer_access_type" {}
# variable "dlv2_workspace_layer" {}

##### databricks_infrastructure.tf
variable "dbr_name" {}
variable "dbr_ws_sku" {}
variable "dbr_managed_rg_name" {}

##### databricks_application.tf
variable "dbr_cluster_name" {}
variable "dbr_autotermination_minutes" {}
variable "dbr_min_workers" {}
variable "dbr_max_worker" {}
# variable "dbr_sql_user" {}
# variable "dbr_sql_group" {}

##### data_factory.tf
variable "df_name" {}
variable "df_identity_type" {}
variable "df_vsts_account_name" {}
variable "df_vsts_branch_name" {}
variable "df_vsts_project_name" {}
variable "df_vsts_repository_name" {}
variable "df_vsts_root_folder" {}
variable "df_vsts_tenant_id" {}
variable "df_vsts_deployment_mode" {}

##### ml_workspace.tf
# variable "ml_workspace_name" {
#   description = "Machine learing wokspace name"
# }
# variable "ml_identity_type" {
#   description = " Specifies the type of Managed Service Identity that should be configured on this ML Workspace. Possible values: SystemAssigned, UserAssigned or both)."
#   default     = "SystemAssigned"
# }

##### authorization.tf
variable "mds_workspace_admin_identity_id" {
  description = "Specifies the ID of the MDS workspace administrator AAD group."
}


##### Synapse
variable "sy_sa_name" {}
variable "sy_account_tier" {}
variable "sy_filesystem_name" {}
variable "sy_workspace_name" {}
variable "account_replication_type" {}
variable "account_kind" {}
variable "is_hns_enabled" {}
variable "sy_identity_type" {}
variable "sy_sql_pool_name" {}
# variable "sql_administrator_login" {}
# variable "sql_administrator_login_password" {}
# variable "sy_keyvault_name" {}
# variable "sy_sku_name" {}
# variable "sy_kv_purge_protection" {}

variable "container_registry_name" {}
variable "service_plan_name" {}
variable "web_app_name" {}

variable "deploy_synapse" {}
variable "deploy_appserviceplan" {}