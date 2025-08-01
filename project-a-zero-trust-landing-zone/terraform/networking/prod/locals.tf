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
  spoke_subnet_prefixes = [
    "10.1.1.0/24",   # App Subnet
    "10.1.2.0/24"    # Data Subnet
  ]
  spoke_subnet_names = [
    "app",
    "data"
  ]
}
