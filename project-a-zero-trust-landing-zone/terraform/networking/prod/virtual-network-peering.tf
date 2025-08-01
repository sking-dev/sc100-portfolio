# NOTE: As of July 2025, there is no Azure Verified Module (AVM) available for VNet Peering.
# For this reason, we use the original 'Azure/vnet-peering/azurerm' public module to manage VNet peerings.
# This approach is recommended until an official AVM module for VNet Peering is released.
module "hub_to_spoke_peering" {
  source                  = "Azure/vnet-peering/azurerm"
  version                 = "~> 2.0.0"
  resource_group_name     = azurerm_resource_group.networking.name
  virtual_network_name    = module.hub_vnet.name
  remote_virtual_network_id = module.spoke_vnet.resource.id
  peering_name            = "hub-to-spoke1"
}

module "spoke_to_hub_peering" {
  source                  = "Azure/vnet-peering/azurerm"
  version                 = "~> 2.0.0"
  resource_group_name     = azurerm_resource_group.networking.name
  virtual_network_name    = module.spoke_vnet.name
  remote_virtual_network_id = module.hub_vnet.resource.id
  peering_name            = "spoke1-to-hub"
}
