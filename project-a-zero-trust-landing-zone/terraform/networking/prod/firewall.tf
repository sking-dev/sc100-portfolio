# TODO: Create variables plus any additional optional inputs to make this code operational.

module "firewall" {
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "~> 0.4.0"

  # Required inputs.  
  firewall_sku_name   = var.firewall_sku_name # Default is "AZFW_VNet".
  firewall_sku_tier   = var.firewall_sku_tier # Default is "Standard".
  location            = azurerm_resource_group.networking.location
  name                = "fw-alz-hub-${var.environment}"
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  firewall_ip_configuration = {
    name                 = var.firewall_ip_configuration_name
    subnet_id            = module.hub_vnet.subnets["AzureFirewallSubnet"].resource_id # Check this syntax.
    public_ip_address_id = var.firewall_public_ip_address_id
  }

  diagnostic_settings = {
    firewall_diag = {
      workspace_resource_id          = data.azurerm_log_analytics_workspace.monitoring.id
      log_analytics_destination_type = "Dedicated"
      log_categories                 = local.log_categories_firewall
      metric_categories              = ["AllMetrics"]
    }
  }

  tags = local.tags
}
