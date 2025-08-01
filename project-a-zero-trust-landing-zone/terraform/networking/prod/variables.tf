variable "location" {
  description = "Azure region for resources."
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource group for networking resources."
  default     = "alz-prod-networking-rg"
}

variable "hub_vnet_address_space" {
  default = "10.0.0.0/16"
}

variable "spoke_vnet_address_space" {
  default = "10.1.0.0/16"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    environment = "prod"
    owner       = "sking-dev"
  }
}
