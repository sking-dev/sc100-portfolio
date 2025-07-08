# Project A – Zero-Trust Landing Zone

| SC-100 Exam Domain               | Weight | Covered in This Project |
|----------------------------------|:------:|-------------------------|
| **Design a Zero-Trust strategy** | 25 %   | ✅ Hub-and-spoke / Private Link / Azure Firewall / Bastion / Conditional Access |

## 1 Purpose

Build an Azure landing zone that applies Zero-Trust principles (network segmentation, identity perimeter) using **Terraform / Bicep**.  
Deployment is fully automated and idempotent.

## 2 Architecture

```plaintext
hub-vnet (10.0.0.0/24)
├─ Azure Firewall
├─ Bastion Host
└─ Spoke VNETs
     ├─ App Subnet
     └─ Data Subnet (Private Link → PaaS)

TODO: Replace with a draw.io / Visio diagram once created.    
```

## 3 Prerequisites

* Terraform ≥ 1.6 **or** Bicep CLI ≥ 0.24  
* Azure CLI — `az login`  
* Azure subscription with **Contributor** or **Owner** role

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
| `azurerm_virtual_network.hub`      | /24 space, gateway & firewall subnets                    |
| `azurerm_firewall.firewall`        | Sends flow logs to Sentinel                              |
| `azurerm_bastion_host.bastion`     | JIT access, no public SSH/RDP                            |
| `azurerm_private_dns_zone.*`       | Maps PaaS endpoints to private IPs                       |
| `azurerm_policy_assignment.*`      | Allowed SKU, tag & location policies                     |

## 6 Validation

* **Azure Policy → Compliance**
  * 0 non-compliant resources
* **Secure Score**
  * Should increase by ~ +10 pts
* Verify Bastion and Private Link endpoints have **no public IP exposure**

## 7 Clean-up

```bash
terraform destroy

# Or, for Bicep deployment.
az deployment sub delete --name zeroTrustLandingZone
```

## 8 Next Iteration Ideas

* Add **Azure Budget** + alert rule  
* Integrate **Infracost** into the CI pipeline for FinOps visibility  
* Extend to multi-region hub-hub VPN  
* Create Sentinel workbook for Firewall & Bastion logs
