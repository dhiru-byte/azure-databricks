# Databricks application settings with the databricks provider
# ============================================================
# Gets the smallest node type for databricks_cluster that fits search criteria like RAM or category
data "databricks_node_type" "smallest_node" {
  category = "General purpose"
}

# Latest spark version with LTS but without GPU and ML options
data "databricks_spark_version" "spark_version" {
  gpu               = false
  ml                = false
  long_term_support = true
  scala             = "2.12"
  spark_version     = "3.3.2"
}
