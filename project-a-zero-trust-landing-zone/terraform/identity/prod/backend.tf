# NOTE: The remote state Storage Account, blob container, and (empty) blob (key) must exist
# before running 'terraform init' for this configuration.
# Terraform cannot create these resources automatically as part of backend initialisation.
# Provision them manually or via a bootstrap script before first use.
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-uks-alz-tfstate-prod"
    storage_account_name  = "alzprodstate"
    container_name        = "tfstate"
    key                   = "identity-prod.terraform.tfstate"
  }
}
