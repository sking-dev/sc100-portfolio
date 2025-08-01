module "private_dns" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "~> 0.4.0"

  # Required inputs.
  domain_name         = "privatelink.database.windows.net"
  parent_id           = azurerm_resource_group.networking.id

  # Optional inputs TBC.

  tags                = var.tags
}
