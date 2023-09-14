variable "dbr_workspace_id" {
  type        = string
  description = "The exported ID of the Azure Databricks Workspace"
}
variable "dbr_cluster_name" {
  type        = string
  description = "Cluster name, which doesn’t have to be unique. If not specified at creation, the cluster name will be an empty string."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags for this resource"
}
variable "dbr_autotermination_minutes" {
  type        = number
  description = "Automatically terminate the cluster after being inactive for this time in minutes."
}
variable "dbr_min_workers" {
  type        = number
  description = "The minimum number of workers to which the cluster can scale down when underutilized."
}
variable "dbr_max_worker" {
  type        = number
  description = "The maximum number of workers to which the cluster can scale up when overloaded. max_workers must be strictly greater than min_workers."
}

variable "ARM_CLIENT_ID" {}
variable "ARM_TENANT_ID" {}
variable "ARM_CLIENT_SECRET" {}

variable "dlv2_name" {}
variable "dlv2_eds_layer_name" {}
# variable "dlv2_workspace_layer" {}

# variable "dbr_sql_user" {
#   type = list(any)
# }
# variable "dbr_sql_group" {
#   type = list(any)
# }
