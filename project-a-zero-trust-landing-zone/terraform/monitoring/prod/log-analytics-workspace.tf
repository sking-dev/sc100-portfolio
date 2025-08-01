
module "log_analytics_workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "~> 0.4.0"

  # Required inputs.  
  location            = azurerm_resource_group.monitoring.location
  name                = "alz-law-${var.environment}" # Consider changing order of naming elements.
  resource_group_name = azurerm_resource_group.monitoring.name

  # Optional inputs.
  log_analytics_workspace_retention_in_days =  30
  log_analytics_workspace_sku               = "PerGB2018"

  tags = local.tags
}
