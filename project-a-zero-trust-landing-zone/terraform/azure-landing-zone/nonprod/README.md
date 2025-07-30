# Non-Production Azure Landing Zone (`nonprod/`)

## Purpose

This directory is reserved for the **Non-Production (NPR) Azure Landing Zone** environment.  
It mirrors the structure and design of the `prod/` landing zone, supporting safe development, testing, and validation of changes before promotion to production.

---

## Proposed Architecture

The NPR landing zone will adopt the **hub-and-spoke network topology** with shared services in the hub and isolated workloads in spokes.

```plaintext
hub-vnet 
  ├─ Azure Firewall 
  ├─ Bastion Host 
  └─ Spoke VNET(s) 
    ├─ App Subnet 
    └─ Data Subnet (Private Link → PaaS)
```

- **Hub VNet**: Centralized for shared services (firewall, Bastion, DNS, etc.)
- **Spoke VNets**: For workloads; each spoke may contain app and data subnets

---

## Proposed Address Spaces

| **Component**   | **Address Space**   | **Subnet(s)**                                      |
|-----------------|---------------------|----------------------------------------------------|
| Hub VNet        | `10.10.0.0/16`      | `AzureFirewallSubnet` : `10.10.1.0/26`<br>`AzureBastionSubnet` : `10.10.2.0/27`<br>`shared-services` : `10.10.4.0/24` |
| Spoke VNet 1    | `10.11.0.0/16`      | `app` : `10.11.1.0/24`<br>`data` : `10.11.2.0/24`  |

> **Tip:** Adjust address spaces and subnet sizes as needed for your actual usage and growth.

---

## To-Do / Next Steps

- Create Terraform files in this directory mirroring the structure of `prod/`
- Parameterize variables (e.g., address spaces, resource group names, tags) for the NPR context
- Link any Private DNS zones to the NPR hub and spokes as appropriate
- Ensure remote state is isolated from Production (separate backend configuration)
- Apply the same security and governance standards as in `prod/`, but with environment-appropriate settings

---

## Notes

- This README serves as a **memory jogger** for the intended architecture and configuration
- Update this file as the NPR environment evolves
- For more details, refer to documentation in the root of the repo or the `prod/` directory

---
