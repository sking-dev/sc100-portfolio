# Identity Domain – Production

This directory contains the Terraform code for managing **Conditional Access (CA) policies** in the Production Azure Landing Zone (ALZ) environment. This supports a Zero Trust security posture and directly aligns with SC-100 learning objectives.

---

## Purpose

- Enforce identity perimeter controls as part of a Zero Trust ALZ
- Manage Conditional Access (CA) policies as code for auditability, repeatability, and compliance
- Demonstrate best practices for enterprise-scale identity governance

---

## What’s Implemented

- **Three “must have” Conditional Access policies:**
  1. **Require MFA for Admin Roles**
  2. **Block Legacy Authentication**
  3. **Require MFA for All Users**
- Policies are implemented using the [AzureAD Terraform provider](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy)

---

## Prerequisites

- **Terraform ≥ 1.6**
- **AzureAD provider** configured (see `provider.tf`)
- **Permissions:**  
  - Executing user or Service Principal must have the **Conditional Access Administrator** (preferred) or **Global Administrator** role in Microsoft Entra ID (Azure AD).
  - Contributor/Owner roles at the ARM/subscription level are **not sufficient**.
- **Azure AD Premium P1 or P2 license** (required for Conditional Access)
- **Remote state backend** (see `backend.tf`) must exist before running `terraform init`

> **Note:** Deploying Conditional Access policies requires Azure AD Premium P1 or P2 licenses in your tenant.  
> If you are using a personal or free Azure tenant without these licenses, you may not be able to test or enforce CA policies.  
> For hands-on testing, consider using the [Microsoft 365 Developer Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program) to obtain a free developer tenant with P1/P2 features.  This is free of charge at the time of writing.

---

## Key Files

- `main.tf` – Conditional Access policy resource definitions
- `provider.tf` – AzureAD provider configuration
- `backend.tf` – Remote state backend configuration

---

## Example: Require MFA for Admin Roles

```hcl
resource "azuread_conditional_access_policy" "require_mfa_admins" {
  display_name = "Require MFA for Admin Roles"
  state        = "enabled"

  conditions {
    users {
      included_roles = [
        "62e90394-69f5-4237-9190-012177145e10" # Global Administrator
      ]
    }
    applications {
      included_applications = ["All"]
    }
    client_app_types = ["all"]
  }

  grant_controls {
    operator = "or"
    built_in_controls = ["mfa"]
  }
}
```

---

## Next Steps

- Add additional Conditional Access policies as required by your Zero Trust strategy
- Document policy rationale and test results in this README
- Integrate CA policy management with your broader ALZ deployment pipeline

---
