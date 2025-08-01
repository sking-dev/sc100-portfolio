resource "azurerm_resource_group" "networking" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
