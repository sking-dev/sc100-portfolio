module "hub_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.9.0"

 # Required inputs.
  address_space       = [var.hub_vnet_address_space]
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  name                = "vnet-alz-hub-${var.environment}"
  subnets             = local.hub_subnet_prefixes

  tags = local.tags
}

module "spoke1_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.9.0"

  # Required inputs.
  address_space       = [var.spoke1_vnet_address_space]
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  name                = "vnet-alz-spoke1-${var.environment}"
  subnets             = local.spoke1_subnet_prefixes

  diagnostic_settings = {
    bastion_diag = {
      workspace_resource_id          = data.azurerm_log_analytics_workspace.monitoring.id
      log_analytics_destination_type = "Dedicated"
      log_categories                 = local.log_categories_vnet
      metric_categories              = ["AllMetrics"]
    }
  }

  tags = local.tags
}
