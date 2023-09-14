variable "rg_name" {
  type        = string
  description = "Name of the resource group."
}

variable "mds_workspace_admin_identity_id" {
  type        = string
  description = "MDS workspace administrator group ID."
}

variable "df_scope_id" {
  type        = string
  description = "DF scope ID."
}

variable "dls_scope_id" {
  type        = string
  description = "Data lake scope ID."
}

variable "dbr_scope_id" {
  description = "Data brick scope ID."
}

variable "workspace_sp_access" {
  description = "sp of the current workspace"
}

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