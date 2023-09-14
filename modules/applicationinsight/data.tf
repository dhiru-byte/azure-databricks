// Resource group info
data "azurerm_resource_group" "ai" {
  name = var.rg_name
}