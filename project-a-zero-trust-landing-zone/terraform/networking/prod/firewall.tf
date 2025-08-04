# NOTE: Create variables plus any additional optional inputs to make this code operational.

module "firewall" {
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "~> 0.4.0"

  # Required inputs.  
  firewall_sku_name   = var.firewall_sku_name # Default is "AZFW_VNet".
  firewall_sku_tier   = var.firewall_sku_tier # Default is "Standard".
  location            = azurerm_resource_group.networking.location
  name                = "hub-firewall-${var.environment}" # Consider changing order of naming elements.
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.
  firewall_ip_configuration = {
    name                 = var.firewall_ip_configuration_name
    subnet_id            = module.hub_vnet.subnets["AzureFirewallSubnet"].resource_id # Check this syntax.
    public_ip_address_id = var.firewall_public_ip_address_id
  }

  tags = local.tags
}
