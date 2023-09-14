# This resource will create all the RBAC roles and assign it to users, applications or service principles. A list of all roles + ids can be found here:
# https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
