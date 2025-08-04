# NOTE: As of July 2025, the Azure Verified Module (AVM) for Network Security Groups is available and recommended.
# We use the AVM module for NSG creation, and the native resource block for subnet association.
module "app_nsg" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "~> 0.5.0"

  # Required inputs.  
  location            = var.location
  name                = "app-nsg-${var.environment}" # Consider changing order of naming elements.
  resource_group_name = azurerm_resource_group.networking.name

  # Optional inputs.  
  security_rules = [
    {
      name                       = "AllowHttpsIn"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow inbound HTTPS"
    },
    # Add more rules as needed
  ]

  tags = local.tags
}

module "data_nsg" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "~> 0.5.0"

  location            = var.location
  name                = "data-nsg" # Consider changing order of naming elements.
  resource_group_name = azurerm_resource_group.networking.name

  security_rules = [
    {
      name                       = "AllowSqlIn"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow inbound SQL"
    },
    # Add more rules as needed
  ]

  diagnostic_settings = {
    bastion_diag = {
      workspace_resource_id          = data.azurerm_log_analytics_workspace.monitoring.id
      log_analytics_destination_type = "Dedicated"
      log_categories                 = local.log_categories_nsg
      metric_categories              = ["AllMetrics"]
    }
  }

  tags = local.tags
}

# Associate each NSG with the relevant subnet.
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = module.spoke_vnet.subnets["app"].resource_id
  network_security_group_id = module.app_nsg.resource.id
}

resource "azurerm_subnet_network_security_group_association" "data" {
  subnet_id                 = module.spoke_vnet.subnets["data"].resource_id
  network_security_group_id = module.data_nsg.resource.id
}
