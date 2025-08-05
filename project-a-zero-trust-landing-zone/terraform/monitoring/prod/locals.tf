locals {
  # Generate short version of Azure location to use in resource naming.
  region_short = var.location == "uksouth" ? "uks" : "ukw"
  
  tags = {
    domain      = var.domain
    environment = var.environment
    owner       = var.owner
  }
}
