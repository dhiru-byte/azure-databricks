# generic variables
variable "rg_name" {}
variable "location" {}

# private subnet
variable "dbr_vnsnprivate_name" {}
variable "dbr_vn_id" {}

# public subnet
variable "dbr_vnsnpublic_name" {}

# vnet
variable "dbr_vn_name" {}

# databricks
variable "dbr_ws_name" {}
variable "dbr_ws_sku" {}
variable "tags" {}
variable "dbr_managed_rg_name" {}

# ML workspace
#variable "ml_workspace_id" {}