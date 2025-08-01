terraform {
  backend "azurerm" {
    resource_group_name  = "foo" # TBC e.g. "rg-uks-terraform-state-prod"
    storage_account_name = "bar" # TBC e.g. "stsktfstateprod3039".
    container_name       = "terraform-state"
    key                  = "alz-prod.tfstate"
  }
}
