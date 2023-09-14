# Data Lake v2 variables
variable "dlv2_name" {}
variable "rg_name" {}
variable "location" {}
variable "workspace_principal_id" {}
variable "dlv2_account_tier" {}
variable "dlv2_account_kind" {}
variable "dlv2_account_replication_type" {}
variable "dlv2_https_traffic_only" {}
variable "dlv2_hns_enabled" {}
variable "dlv2_network_rules_default_action" {}
variable "dlv2_virtual_network_subnet_ids" {}
variable "tags" {}

# Enterprisedataservices container
variable "dlv2_eds_layer_name" {}

# # Workspace container
# variable "dlv2_workspace_layer" {}

# Databricks public & private subnets
variable "dbr_vn_name" {}
variable "dbr_vnsnpublic_name" {}
variable "dbr_vnsnprivate_name" {}

# Log analytics
variable "la_id" {}

# First role
variable "dlv2_role_1_definition_name" {}
variable "dlv2_role_1_principal_id" {}

# Second role
variable "dlv2_role_2_definition_name" {}
variable "dlv2_role_2_principal_id" {}
