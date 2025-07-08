<!--
  Repo        : sc100-portfolio
  Purpose     : Hands-on projects for the Microsoft SC-100 Cybersecurity Architect Expert exam
  Maintainer  : sking-dev
-->

# 🚀 SC-100 Portfolio

```plaintext
Zero-Trust | Policy-as-Code | AKS Guardrails | AI-SecOps & FinOps
```

This repository hosts four practical projects that map **1-to-1** to the  **SC-100 Cybersecurity Architect Expert** exam domains.

Everything is Infrastructure-as-Code-first (Terraform / Bicep) and blends security, FinOps and AI capabilities.

| Project Folder | SC-100 Domain | Status |
| -------------- | ------------- | ------ |
| [`project-a-zero-trust-landing-zone`](./project-a-zero-trust-landing-zone/) | 1 - Design a Zero-Trust strategy (25 %) | 🔨 Scaffolded |
| [`project-b-policy-as-code`](./project-b-policy-as-code/)                 | 2 - Evaluate governance & compliance (20 %) | ⏳ Pending |
| [`project-c-aks-guardrails`](./project-c-aks-guardrails/)                 | 3 - Design infrastructure security (35 %) | ⏳ Pending |
| [`project-d-sentinel-gpt`](./project-d-sentinel-gpt/)                     | 4 - Design security operations (20 %)     | ⏳ Pending |

## 📑 Skills-Mapping Table

The detailed cross-walk can be found in the roadmap repo: <https://github.com/sking-dev/ai-sec-roadmaps/blob/main/docs/sc100_skills_uplift_roadmap.md>

## 🛠 Prerequisites

* Azure subscription with **Contributor** rights  
* **Terraform ≥ 1.6** and / or **Bicep CLI ≥ 0.24**  
* **Azure CLI** – `az login`  
* *(Optional)* VS Code with Terraform, Bicep & Azure extensions

## 🚗 Quick Start

```bash
# Clone repository.
git clone https://github.com/<your-handle>/sc100-portfolio.git
cd sc100-portfolio/project-a-zero-trust-landing-zone

# Deploy (Terraform example)
terraform init
terraform apply

# Destroy demo resources.
terraform destroy
```

## 🗂 Repo Structure

```plaintext
sc100-portfolio/
├─ project-a-zero-trust-landing-zone/
├─ project-b-policy-as-code/
├─ project-c-aks-guardrails/
└─ project-d-sentinel-gpt/
```

## 📅 Roadmap

### Project A – Zero-Trust Landing Zone

* [x] Scaffold project folder & README  
* [ ] Build hub-and-spoke VNet + Azure Firewall  
* [ ] Add Private Link, Bastion and Conditional Access policies  
* [ ] Commit architecture diagram & deployment guide  

### Project B – Policy-as-Code & Secure Score Uplift

* [ ] Scaffold project folder & README  
* [ ] Author custom Azure Policy set (CAF + CIS)  
* [ ] Integrate **tfsec** + **Infracost** in Azure DevOps pipeline  
* [ ] Capture before / after Secure Score metrics  

### Project C – AKS Guardrails

* [ ] Scaffold project folder & README  
* [ ] Deploy AKS cluster via Terraform/Bicep  
* [ ] Add OPA Gatekeeper with three Rego policies  
* [ ] Generate Trivy SBOM & sign images with Cosign  
* [ ] Export Kubecost / OpenCost report to Log Analytics  

### Project D – Sentinel + GPT-4o Incident "Triager"

* [ ] Scaffold project folder & README  
* [ ] Create custom Sentinel analytic rule (AKS audit logs)  
* [ ] Build Logic App → Azure Function → GPT-4o summary  
* [ ] Post MITRE-mapped incident brief to Teams  
* [ ] Log token usage & set budget alert

## Disclaimer

All code is demo-grade. **Do not** deploy to production without full security, compliance and cost review.
