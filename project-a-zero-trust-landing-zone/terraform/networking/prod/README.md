# Production Azure Landing Zone (`prod/`)

## Purpose

This directory contains the **Infrastructure as Code (IaC)** for deploying the **Production Azure Landing Zone (ALZ)** environment.

It implements a secure, scalable, and governed foundation for production workloads in Azure, following enterprise-scale and Cloud Adoption Framework (CAF) best practices.

---

## Architecture Overview

The production landing zone uses a **hub-and-spoke network topology** to centralize shared services and securely isolate workloads.

```plaintext
hub-vnet 
  ├─ Azure Firewall 
  ├─ Bastion Host 
  └─ Spoke VNET(s) 
    ├─ App Subnet 
    └─ Data Subnet (Private Link → PaaS)
```

- **Hub VNet:**  
  Centralized for shared services (firewall, Bastion, DNS, etc.)
- **Spoke VNets:**  
  Isolated per workload/application; each spoke may contain app and data subnets

---

## Address Spaces

| **Component**   | **Address Space**   | **Subnet(s)**                                      |
|-----------------|---------------------|----------------------------------------------------|
| Hub VNet        | `10.0.0.0/16`       | `AzureFirewallSubnet` : `10.0.1.0/26`<br>`AzureBastionSubnet` : `10.0.2.0/27`<br>`shared-services` : `10.0.4.0/24` |
| Spoke VNet 1    | `10.1.0.0/16`       | `app` : `10.1.1.0/24`<br>`data` : `10.1.2.0/24`    |

> **Note:** Expand subnetting as needed for additional spokes or services.

---

## Key Components

- **Hub VNet:**  
  Shared services, network security, and central routing.
- **Azure Firewall:**  
  Centralized traffic inspection and control.
- **Bastion Host:**  
  Secure browser-based RDP/SSH to VMs, no public IPs required.
- **Spoke VNets:**  
  Workload isolation and segmentation.
- **Private DNS Zone:**  
  Internal name resolution, especially for Private Link/PaaS resources.
- **VNet Peering:**  
  Secure connectivity between hub and spokes.

---

## Proposed Terraform File Structure

```plaintext
prod/
├── main.tf                # (optional, can be empty or contain high-level resources/module calls)
├── provider.tf            # Provider configuration (e.g., azurerm, backend config)
├── backend.tf             # Remote state backend configuration (if separated from provider.tf)
├── variables.tf           # All input variables for this environment
├── outputs.tf             # All outputs for this environment
├── locals.tf              # Local values, naming conventions, computed variables
├── virtual-network.tf     # Hub and spoke VNets, subnets, VNet peering modules
├── firewall.tf            # Azure Firewall module and related configuration
├── bastion.tf             # Azure Bastion Host module and settings
├── private-dns.tf         # Private DNS zones, links, and related resources
├── nsg.tf                 # Network Security Groups, rules, and associations (optional)
├── route-table.tf         # Route tables and associations (optional)
├── README.md              # Documentation for the prod landing zone
└──...                     # Add more files as needed (e.g. for key vault, monitoring, etc.)
```

### Typical File Contents

- `main.tf`
  - High-level orchestration, or can be left empty if all resources are in modular files
- `provider.tf`
  - Azure provider block, version constraints, and backend (if not split)
- `backend.tf`
  - Remote state configuration (e.g. Azure Storage Account for state files)
- `variables.tf`
  - All variables used in this environment, with defaults or descriptions
- `outputs.tf`
  - Output values for resource IDs, IPs, etc., for reference or use in other stacks
- `locals.tf`
  - Local values for naming conventions, computed variables, or environment-specific logic
- `virtual-network.tf`
  - Hub and spoke VNet definitions, subnets, and VNet peering modules
- `firewall.tf`
  - Azure Firewall deployment and rules
- `bastion.tf`
  - Azure Bastion Host deployment
- `private-dns.tf`
  - Private DNS zones, VNet links, and records for Private Link / PaaS
- `nsg.tf`
  - NSG definitions and associations to subnets (optional, but recommended)
- `route-table.tf`
  - Custom route tables and associations (optional, for advanced routing)

---

## Resource Naming Conventions

To ensure clarity, consistency, and scalability across the Azure Landing Zone, all resource groups and resources follow the naming patterns below.

### Resource Groups

**Pattern:**  
`rg-<location>-<project>-<domain>-<environment>`

**Example:**  
`rg-uks-alz-networking-prod`

- `location`: Azure region short name (e.g., `uks` for UK South, `eus` for East US)
- `project`: Project or workload name (e.g., `alz`)
- `domain`: Functional domain (e.g., `networking`, `monitoring`, `identity`)
- `environment`: Environment (e.g., `prod`, `nonprod`, `dev`, `test`)

### Networking Resources

**Pattern:**  
`<type>-<project>-<hub|spokeX>-<role>-<environment>`

**Examples:**

- Hub VNet: `vnet-alz-hub-prod`
- Spoke 1 VNet: `vnet-alz-spoke1-prod`
- Hub Bastion: `bastion-alz-hub-prod`
- Hub Firewall: `fw-alz-hub-prod`
- Spoke 1 NSG (App Subnet): `nsg-alz-spoke1-app-prod`
- Spoke 1 NSG (Data Subnet): `nsg-alz-spoke1-data-prod`
- Spoke 1 App Subnet: `subnet-app-alz-spoke1-prod`
- Hub Shared Services Subnet: `subnet-shared-alz-hub-prod`

- `type`: Resource type abbreviation (e.g., `vnet`, `nsg`, `bastion`, `fw`, `subnet-app`)
- `project`: Project or workload name (e.g., `alz`)
- `hub|spokeX`: Logical network segment (`hub`, `spoke1`, `spoke2`, etc.)
- `role`: Subnet or NSG role (e.g., `app`, `data`, `shared`, `mgmt`)
- `environment`: Environment (`prod`, `nonprod`)

> **Note:** The domain is included in the resource group name but not typically in the individual resource name, unless needed for disambiguation.  The `hub`/`spokeX` distinction is always included for networking resources to support clarity and scalability.  
The `role` field is especially important for NSGs and subnets to avoid ambiguity and support clear mapping between resources.

### Rationale

- **Location** and **environment** are always included in resource group names for clarity and to prevent ambiguity in multi-region or multi-environment deployments.
- **Project/workload**, **type**, and **logical segment** (`hub`/`spokeX`) ensure resources are easily identifiable, grouped logically, and scalable as the environment grows.
- This pattern aligns with [Microsoft’s CAF naming and tagging best practices](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) and supports enterprise-scale ALZ and Zero Trust architectures.

---

## Getting Started

- Review and update variables in `variables.tf` as needed for your environment
- Ensure backend configuration (`backend.tf`) points to the correct remote state storage
- Apply changes using standard Terraform workflow
  - `terraform init / terraform plan / terraform apply`
- Follow security and governance practices as outlined in your organization’s Azure policy.

---

## Notes

- This directory is **production-focused**; changes should be validated in `nonprod/` before promotion
- Keep this README updated as the architecture evolves
- For more details, see documentation in the repo root or the `nonprod/` directory

---
