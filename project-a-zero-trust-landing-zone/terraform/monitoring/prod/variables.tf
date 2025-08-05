variable "domain" {
  description = "The functional domain for this deployment (e.g. networking, monitoring, identity, governance)  Used for tagging and resource organisation."
  type        = string
  default     = "monitoring"
}

variable "environment" {
  description = "The logical environment for this deployment (e.g. prod, nonprod, dev, test)  Used for naming, tagging, and environment-specific configuration."
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for resources."
  default     = "uksouth"
}

variable "owner" {
  description = "The owner of the Azure resources."
  type        = string
  default     = "sking-dev"
}
