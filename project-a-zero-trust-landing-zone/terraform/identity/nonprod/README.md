# Identity Domain – Non-Production

This directory is reserved for the **Non-Production (NPR)** Azure Landing Zone (ALZ) identity environment.

## Status

- No Conditional Access policies or identity resources are currently deployed in NPR
- When NPR is enabled, it will mirror the structure and configuration of `/identity/prod/` for consistency and safe testing of changes before promotion to production

## Next Steps

- When ready, copy or adapt the Terraform code from `/identity/prod/` to deploy Conditional Access policies and other identity resources for NPR
- Update any variable values (e.g. environment, excluded users) as needed to reflect non-production context

---
