# Cross-Domain Dependencies

These are the cross-domain dependencies to be aware of when using this codebase to build out an enterprise-scale Azure Landing Zone.

Understanding these dependencies ensures correct deployment order, safe resource referencing, and easier maintenance as your ALZ grows in complexity.

- **Log Analytics Workspace (LAW)**
  - Deployed in `/monitoring/prod`
  - Referenced by `/networking/prod`, `/identity/prod`, and `/governance/prod` via data blocks for diagnostic settings
  - Example:  

    ```hcl
    data "azurerm_log_analytics_workspace" "law" {
      name                = "alz-law-prod"
      resource_group_name = "rg-uks-alz-monitoring-prod"
    }
    ```  

- **Terraform Remote State**
  - All domains use the same centralized Storage Account and container for remote state, with unique keys per domain/environment
- **Conditional Access Policies**
  - Managed in `/identity/prod`, require Azure AD Premium P1/P2 and appropriate Entra ID roles
  - No direct dependency on ARM resources, but may impact access to resources managed in other domains
