# Generic
variable "rg_name" {}
variable "location" {}

# Databricks Network Security Group
variable "dbr_nsg_name" {}
variable "tags" {}

# Databricks Virtual Network
variable "dbr_vn_name" {}
variable "dbr_vn_address_space" {}

# Databricks public subnet
variable "dbr_vnsnpublic_name" {}
variable "dbr_vnsnpublic_address_prefixes" {}
variable "dbr_vnsnpublic_service_endpoints" {}
variable "dbr_vnsnpublic_delegate_name" {}
variable "dbr_vnsnpublic_service_delegation_name" {}
variable "dbr_vnsnpublic_service_delegations_actions" {}

# Databricks private subnet
variable "dbr_vnsnprivate_name" {}
variable "dbr_vnsnprivate_address_prefixes" {}
variable "dbr_vnsnprivate_service_endpoints" {}
variable "dbr_vnsnprivate_delegate_name" {}
variable "dbr_vnsnprivate_service_delegation_name" {}
variable "dbr_vnsnprivate_service_delegations_actions" {}