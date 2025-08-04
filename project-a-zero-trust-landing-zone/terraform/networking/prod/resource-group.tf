resource "azurerm_resource_group" "networking" {
  name     = "alz-${var.domain}-rg-${var.location}" # Consider changing order of naming elements.
  location = var.location

  tags     = local.tags
}
