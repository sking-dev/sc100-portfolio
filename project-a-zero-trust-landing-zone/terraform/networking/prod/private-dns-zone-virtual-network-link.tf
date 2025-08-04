# NOTE: As of July 2025, there is no Azure Verified Module (AVM) available for Private DNS Zone VNet Links.
# For this reason, we use the native 'azurerm_private_dns_zone_virtual_network_link' resource block.
# This approach is recommended and future-proof until an AVM module is released.
resource "azurerm_private_dns_zone_virtual_network_link" "hub_link" {
  name                  = "hub-vnet-link" # Consider changing order of naming elements.
  resource_group_name   = azurerm_resource_group.networking.name
  private_dns_zone_name = module.private_dns.name
  virtual_network_id    = module.hub_vnet.resource.id
  registration_enabled  = false
  
  tags                  = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
  name                  = "spoke-vnet-link" # Consider changing order of naming elements.
  resource_group_name   = azurerm_resource_group.networking.name
  private_dns_zone_name = module.private_dns.name
  virtual_network_id    = module.spoke_vnet.resource.id
  registration_enabled  = false

  tags                  = local.tags
}
