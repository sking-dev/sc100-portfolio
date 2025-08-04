# Data source to enable retrieval of attributes from existing Log Analytics workspace deployed by the /monitoring domain.
data "azurerm_log_analytics_workspace" "monitoring" {
  name                = "law-alz-${var.environment}"
  resource_group_name = "rg-${var.location}-alz-monitoring-${var.environment}"
}
