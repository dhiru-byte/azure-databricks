# The Databricks Cluster
resource "databricks_cluster" "cluster" {
  cluster_name            = var.dbr_cluster_name
  spark_version           = data.databricks_spark_version.spark_version.id
  node_type_id            = data.databricks_node_type.smallest_node.id
  autotermination_minutes = var.dbr_autotermination_minutes
  custom_tags             = var.tags

  autoscale {
    min_workers = var.dbr_min_workers
    max_workers = var.dbr_max_worker
  }
  # spark_conf = {
  #   "spark.databricks.repl.allowedLanguages" : "true",
  #   "spark.databricks.acl.dfAclsEnabled" : "true",
  #   "spark.databricks.delta.preview.enabled" : "true",
  # }
  depends_on = [data.databricks_spark_version.spark_version]
}

# mount dls container "enterprisedataservices" on databricks cluster
resource "databricks_mount" "mount_enterprisedataservices_container" {
  name       = var.dlv2_eds_layer_name
  cluster_id = databricks_cluster.cluster.id
  uri        = "abfss://${var.dlv2_eds_layer_name}@${var.dlv2_name}.dfs.core.windows.net"
  extra_configs = {
    "fs.azure.account.auth.type" : "OAuth",
    "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "fs.azure.account.oauth2.client.id" : var.ARM_CLIENT_ID,
    "fs.azure.account.oauth2.client.secret" : var.ARM_CLIENT_SECRET,
    "fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${var.ARM_TENANT_ID}/oauth2/token"
  }
  depends_on = [databricks_cluster.cluster]
}

# # mount dls container "workspace" on databricks cluster
# resource "databricks_mount" "workspace_container" {
#   name       = var.dlv2_workspace_layer
#   cluster_id = databricks_cluster.cluster.id

#   uri = "abfss://${var.dlv2_workspace_layer}@${var.dlv2_name}.dfs.core.windows.net"
#   extra_configs = {
#     "fs.azure.account.auth.type" : "OAuth",
#     "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
#     "fs.azure.account.oauth2.client.id" : var.ARM_CLIENT_ID,
#     "fs.azure.account.oauth2.client.secret" : var.ARM_CLIENT_SECRET,
#     "fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${var.ARM_TENANT_ID}/oauth2/token"
#   }
#   depends_on = [databricks_cluster.cluster]
# }

