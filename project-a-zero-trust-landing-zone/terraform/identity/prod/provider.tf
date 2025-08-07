# The "azuread" provider operates at the Microsoft Entra ID tenant level.
# To deploy Conditional Access policies, the executing user or service principal (SPN)
# must have the "Conditional Access Administrator" or "Global Administrator" role in Entra ID.
# NOTE: "Conditional Access Administrator" should be the preferred choice for this purpose.
# For pipelines, ensure the SPN is assigned one of these directory roles before deployment.
# (Contributor or Owner roles in ARM/subscription are NOT sufficient.)
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80" # Check latest available stable version.
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50.0" # Check latest available stable version.
    }
  }
}

provider "azurerm" {
  features {}
  # Optionally specify subscription_id if needed:
  # subscription_id = var.subscription_id
}

provider "azuread" {
  # Optionally specify tenant_id if you want to be explicit:
  # tenant_id = var.tenant_id
}
