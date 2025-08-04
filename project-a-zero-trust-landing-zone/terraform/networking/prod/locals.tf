locals {
  hub_subnet_prefixes = [
    "10.0.1.0/26",   # AzureFirewallSubnet
    "10.0.2.0/27",   # AzureBastionSubnet
    "10.0.4.0/24"    # Shared services
  ]
  hub_subnet_names = [
    "AzureFirewallSubnet",
    "AzureBastionSubnet",
    "shared-services"
  ]

  # Bastion host log catagories.
  log_categories_bastion = [
    "BastionAuditLogs"
  ]
  # Azure Firewall log categories.
  log_categories_firewall = [
    "AzureFirewallApplicationRule",
    "AzureFirewallNetworkRule",
    "AzureFirewallDnsProxy",
    "AzureFirewallThreatIntel"
  ]
  # Network Security Group (NSG) log categories.
  log_categories_nsg = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]
  # Virtual Network log categories.
  log_categories_vnet = [
    "VMProtectionAlerts"
  ]

  spoke_subnet_prefixes = [
    "10.1.1.0/24",   # App Subnet
    "10.1.2.0/24"    # Data Subnet
  ]
  spoke_subnet_names = [
    "app",
    "data"
  ]

  tags = {
    domain      = var.domain
    environment = var.environment
    owner       = var.owner
  }
}
