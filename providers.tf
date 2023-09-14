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

provider "databricks" {
  azure_workspace_resource_id = module.databricks_infra.databricks_resource_id
  azure_client_id             = var.ARM_CLIENT_ID
  azure_client_secret         = var.ARM_CLIENT_SECRET
  azure_tenant_id             = var.ARM_TENANT_ID
}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = var.ARM_SUBSCRIPTION_ID
  client_id                  = var.ARM_CLIENT_ID
  client_secret              = var.ARM_CLIENT_SECRET
  tenant_id                  = var.ARM_TENANT_ID
  features {}
}
