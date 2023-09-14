##### Resource groups are managed by Nutreco. We do NOT deploy our own resource groups!.##### If you need resource group create request in servicenow and provide group information here as data for usage with other components.

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
