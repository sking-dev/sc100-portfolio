module "hub_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.9.0"

 # Required inputs.
  address_space       = [var.hub_vnet_address_space]
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  name                = "hub-vnet"
  subnets             = local.hub_subnet_prefixes

  tags                = var.tags
}

module "spoke_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.9.0"

  name                = "spoke1-vnet"
  resource_group_name = azurerm_resource_group.networking.name
  location            = azurerm_resource_group.networking.location
  address_space       = [var.spoke_vnet_address_space]
  subnets             = local.spoke_subnet_prefixes
  tags                = var.tags
}
