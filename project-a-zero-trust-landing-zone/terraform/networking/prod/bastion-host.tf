# TODO: Create variables plus any additional optional inputs to make this code operational.
module "bastion" {
  source  = "Azure/avm-res-network-bastionhost/azurerm"
  version = "~> 0.8.0"

  # Required inputs.
  location            = azurerm_resource_group.networking.location
  name                = "bastion-alz-hub-${var.environment}"
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  ip_configuration = {
    name                 = var.bastion_ip_configuration_name
    subnet_id            = module.hub_vnet.subnets["AzureBastionSubnet"].resource_id # Check syntax.
    public_ip_address_id = var.bastion_public_ip_address_id
  }

  diagnostic_settings = {
    bastion_diag = {
      workspace_resource_id          = data.azurerm_log_analytics_workspace.monitoring.id
      log_analytics_destination_type = "Dedicated"
      log_categories                 = local.log_categories_bastion
      metric_categories              = ["AllMetrics"]
    }
  }

  tags = local.tags
}
