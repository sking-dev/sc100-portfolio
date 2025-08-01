# Monitoring – Production

This directory contains the Terraform code for deploying monitoring resources in the **Production** Azure Landing Zone environment.

## What’s Deployed

- **Log Analytics Workspace** (`alz-law-prod`)
  - Centralized workspace for diagnostics/logs from networking, identity, governance, and other domains.
- (Optional) Additional monitoring solutions (e.g., Azure Sentinel) can be added here.

## Usage

- Deploy this code before referencing the workspace in other domains (e.g., networking, identity).
- Other domains should use a data block to reference the workspace by name and resource group.

## Zero Trust & SC-100 Alignment

Centralized monitoring and diagnostics are critical for Zero Trust visibility, threat detection, and compliance, supporting your SC-100 learning objectives.

---
