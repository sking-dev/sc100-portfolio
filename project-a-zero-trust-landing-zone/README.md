# Project A – Zero-Trust Landing Zone

| SC-100 Exam Domain               | Weight | Covered in This Project |
|----------------------------------|:------:|-------------------------|
| **Design a Zero-Trust strategy** | 25 %   | ✅ Hub-and-spoke / Private Link / Azure Firewall / Bastion / Conditional Access |

## 1 Purpose

Build an Azure Landing Zone (ALZ) that applies Zero Trust principles —such as network segmentation, identity perimeter, and least privilege — using Terraform (with Azure Verified Modules where available).

The deployment is fully automated, idempotent, and designed for enterprise scalability.

> **NOTE:** While this project currently focuses on Terraform, future iterations may include equivalent Bicep templates for key scenarios. This will illustrate how core ALZ and Zero Trust patterns can be implemented using either IaC tool, supporting both SC-100 exam preparation and practical portfolio development.

## Repository Structure

This repo uses a domain-centric layout to maximize clarity and separation of concerns.

```plaintext
azure-landing-zone/
└── terraform/
    ├── networking/
    │   ├── prod/
    │   └── nonprod/
    ├── identity/
    │   ├── prod/
    │   └── nonprod/
    ├── governance/
    │   ├── prod/
    │   └── nonprod/
    └── modules/ # Optional (may not be required)
```

- Each domain (`networking`, `identity`, `governance`) is managed independently
- Each environment (`prod`, `nonprod`) is isolated with its own configuration and state
- **AVM modules for Terraform** are used for core resources; public modules or native resources fill any gaps

## 2 Architecture

### ALZ Hub-and-Spoke Architecture (Text Diagram)

```plaintext
+-----------------------------------------------------------------+
|                  Resource Group: alz-prod-networking-rg         |
|                                                                 |
|    +---------------------+                                      |
|    |      hub-vnet       |                                      |
|    |---------------------|                                      |
|    |  [Azure Firewall]   |                                      |
|    |  [Bastion Host]     |                                      |
|    |  [Private DNS Zone] |<----------------------+              |
|    +---------------------+                   |   |              |
|           |   |                              |   |              |
|           |   | VNet Peering                 |   | VNet Peering |
|           |   |                              |   |              |
|   +---------------------+          +---------------------+      |
|   |    spoke1-vnet      |          |    spoke2-vnet      |      |
|   |---------------------|          |---------------------|      |
|   |  [app subnet]       |          |  [app subnet]       |      |
|   |  [data subnet]      |          |  [data subnet]      |      |
|   +---------------------+          +---------------------+      |
|           |                              |                      |
|           +------------------------------+----------------------+
|                      Private DNS Zone Links                     |
+-----------------------------------------------------------------+
```

## 3 Prerequisites

- Terraform ≥ 1.6 **or** Bicep CLI ≥ 0.24  
- Azure CLI — `az login`  
- Azure subscription with **Contributor** or **Owner** role

## 4 Deployment (Quick Start)

### Terraform

```bash
cd project-a-zero-trust-landing-zone
terraform init
terraform apply
```

### Bicep

```bash
az bicep build --file main.bicep
az deployment sub create \
  --location uksouth \
  --template-file main.json \
  --parameters @parameters.json
```

## 5 What Gets Deployed

| Resource                           | Notes                                                     |
|------------------------------------|-----------------------------------------------------------|
| `azurerm_virtual_network.hub`      | /24 space, gateway & firewall subnets                     |
| `azurerm_firewall.firewall`        | Sends flow logs to Sentinel                               |
| `azurerm_bastion_host.bastion`     | JIT access, no public SSH/RDP                             |
| `azurerm_private_dns_zone.*`       | Maps PaaS endpoints to private IPs                        |
| `azurerm_policy_assignment.*`      | Allowed SKU, tag & location policies                      |

Resource names above reflect logical resources; implementation may use AVM modules, public modules, or native resource blocks as described below.

## Modules Used (Terraform)

- Azure Verified Modules (AVM) for Terraform
  - Used for core networking resources (VNet, Firewall, Bastion, Private DNS Zone, NSG)
- Original public module (`Azure/vnet-peering/azurerm`)
  - Used for VNet Peering , as no AVM module is available yet
- Native Terraform resource blocks
  - Used for Private DNS Zone VNet Links (no AVM or public modules available)

## Diagnostic Settings

All core networking resources — including Virtual Networks, Firewalls, Bastion Hosts, NSGs, and Private DNS Zones — are configured to send diagnostic logs and metrics to a centralized Log Analytics workspace.

This enables monitoring, auditing, and threat detection in alignment with Zero Trust and SC-100 best practices.

## Policy and Conditional Access

- **Azure Policy assignments** - e.g. allowed locations, SKUs, required tags - are managed in the `/governance/` directory, separate from networking code, to ensure clear governance and compliance boundaries
- **Conditional Access policies** - e.g. requiring MFA, restricting access by device or location - are managed in the `/identity/` directory using the AzureAD provider, reflecting their role as identity controls rather than network or resource policies

This separation aligns with Microsoft’s best practices for enterprise ALZ and Zero Trust architectures, and supports clear auditability and change management.

## 6 Validation

- **Azure Policy → Compliance**
  - 0 non-compliant resources
- **Secure Score**
  - Should increase by ~ +10 pts
- Verify Bastion and Private Link endpoints have **no public IP exposure**

## 7 Clean-up

```bash
terraform destroy

# Or, for Bicep deployment.
az deployment sub delete --name zeroTrustLandingZone
```

## 8 Next Iteration Ideas

- Add **Azure Budget** + alert rule  
- Integrate **Infracost** into the CI pipeline for FinOps visibility  
- Extend to multi-region hub-hub VPN  
- Create Sentinel workbook for Firewall & Bastion logs
