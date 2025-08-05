resource "azurerm_resource_group" "monitoring" {
  name     = "rg-${local.region_short}-alz-${var.domain}-${var.environment}"
  location = var.location
  
  tags = local.tags
}
