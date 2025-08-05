variable "domain" {
  description = "The functional domain for this deployment (e.g. networking, monitoring, identity, governance)  Used for tagging and resource organisation."
  type        = string
  default     = "networking"
}

variable "environment" {
  description = "The logical environment for this deployment (e.g. prod, nonprod, dev, test)  Used for naming, tagging, and environment-specific configuration."
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for resources."
  default     = "East US"
}

variable "owner" {
  description = "The owner of the Azure resources."
  type        = string
  default     = "sking-dev"
}

variable "resource_group_name" {
  description = "Resource group for networking resources."
  default     = "alz-prod-networking-rg"
}

variable "hub_vnet_address_space" {
  default = "10.0.0.0/16"
}

variable "spoke1_vnet_address_space" {
  default = "10.1.0.0/16"
}
