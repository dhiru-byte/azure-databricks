# General variables
variable "rg_name" {}
variable "location" {}
variable "tags" {}

# Data Factory specific variables
variable "df_name" {}
variable "df_identity_type" {}

# Data factory azure repo configuration
variable "df_vsts_account_name" {}
variable "df_vsts_branch_name" {}
variable "df_vsts_project_name" {}
variable "df_vsts_repository_name" {}
variable "df_vsts_root_folder" {}
variable "df_vsts_tenant_id" {}
variable "df_vsts_deployment_mode" {}
variable "environment_name" {}

# diagnosticsettings
# variable "la_id" {}
