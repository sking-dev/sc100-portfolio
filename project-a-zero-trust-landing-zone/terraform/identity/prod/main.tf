# NOTE: All Conditional Access policies are currently defined in this main.tf file for simplicity.
# As the number of policies grows, consider splitting each policy into its own .TF file
# (e.g., conditional-access-require-mfa-admins.tf, conditional-access-block-legacy-auth.tf).
# Place any new code for additional Identity services (e.g., groups, app registrations, role assignments)
# in separate, logically-named .TF files for clarity and maintainability.
resource "azuread_conditional_access_policy" "require_mfa_admins" {
  display_name = "Require MFA for Admin Roles"
  state        = "enabled"

  conditions {
    users {
      included_roles = [
        "62e90394-69f5-4237-9190-012177145e10" # Global Administrator
        # Add more role IDs as needed
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

####

resource "azuread_conditional_access_policy" "block_legacy_auth" {
  display_name = "Block Legacy Authentication for All Users"
  state        = "enabled"

  conditions {
    users {
      included_users = ["All"]
    }
    applications {
      included_applications = ["All"]
    }
    client_app_types = [
      "exchangeActiveSync",
      "other"
    ]
  }

  grant_controls {
    operator = "or"
    built_in_controls = ["block"]
  }
}

####

resource "azuread_conditional_access_policy" "require_mfa_all_users" {
  display_name = "Require MFA for All Users"
  state        = "enabled"

  conditions {
    users {
      included_users = ["All"]
      # Optionally exclude break-glass accounts by object ID
      # to avoid being locked out if MFA is unavailable.
      # excluded_users = ["<break-glass-user-object-id>"]
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
