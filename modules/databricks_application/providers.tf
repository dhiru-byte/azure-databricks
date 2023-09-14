# Non-default providers need to be reinitialized in the module itself
# https://github.com/hashicorp/terraform/issues/25984
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.14.3"
    }
  }
  backend "azurerm" {}
}