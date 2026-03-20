# Terraform Enterprise — Azure Infrastructure Automation

A fully automated Infrastructure-as-Code (IaC) project that provisions secure,
production-ready Azure infrastructure using Terraform and Azure DevOps pipelines.
The project demonstrates cloud automation, remote state management, network
security, and CI/CD-driven infrastructure lifecycle management.

---

## 🌐 Overview

This repository contains Terraform configurations and Azure DevOps pipeline
definitions that deploy a Linux virtual machine and supporting Azure resources
using enterprise-grade practices. The goal is to show how Terraform, Azure
DevOps, and Azure services work together to deliver consistent, repeatable,
and secure cloud environments.

---

## ✅ Key Features

- Automated provisioning of Azure infrastructure using Terraform
- Azure DevOps CI/CD pipeline for plan/apply/destroy
- Secure remote state stored in Azure Blob Storage
- Virtual Network, Subnets, NSGs, and Linux VM deployment
- Parameterized and reusable Terraform variables
- End-to-end infrastructure lifecycle automation
- Manual approval gate before infrastructure destroy

---

## 🏗️ Architecture

The deployed infrastructure includes:

- Resource Group for all assets
- Virtual Network (10.0.0.0/16) with Subnet (10.0.1.0/24)
- Network Security Group with controlled inbound rules (SSH + HTTP)
- Public IP + NIC for the VM
- Linux Virtual Machine (Ubuntu 22.04 LTS Gen2, Standard_D2s_v3)
- Azure Storage Account for Terraform remote state
- Azure DevOps Pipeline for CI/CD automation

### High-Level Flow

Git Push → Azure DevOps Pipeline → Terraform Init/Plan/Apply → Azure Infrastructure

## 📁 Repository Structure
terraform-enterprise/
│
├── main.tf # Core infrastructure resources
├── variables.tf # Input variable definitions
├── outputs.tf # Output values
├── backend.tf # Remote state configuration
├── azure-pipelines.yml # Azure DevOps CI/CD pipeline
├── .gitignore # Ignored files
└── README.md # Project documentation


---

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.0+
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Active Azure Subscription
- Azure DevOps organisation and project

### Setup

```bash
# Clone the repository
git clone https://github.com/Heydevopsproductbased/terraform-enterprise.git
cd terraform-enterprise

# Login to Azure
az login

# Create state storage (one-time)
az group create --name rg-terraform-state --location northeurope
az storage account create --name tfstatepriyanka \
  --resource-group rg-terraform-state \
  --location northeurope --sku Standard_LRS
az storage container create --name tfstate --account-name tfstatepriyanka

# Initialise Terraform
terraform init \
  -backend-config="resource_group_name=rg-terraform-state" \
  -backend-config="storage_account_name=tfstatepriyanka" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform.tfstate"

# Plan and Apply
terraform plan -var="admin_password=YOUR_PASSWORD" -out=tfplan
terraform apply tfplan

🔁 Pipeline Stages
Stage	Description
Validate	Checks Terraform syntax with terraform validate
Plan	Generates execution plan, saved as pipeline artifact
Apply	Downloads plan artifact and deploys infrastructure
Destroy	Tears down all resources — requires manual approval

🔒 Security Considerations
Remote state stored in secure Azure Blob Storage (dedicated resource group)

NSG rules restrict inbound traffic to SSH (22) and HTTP (80) only

Sensitive variables stored as pipeline secrets, never hardcoded

State storage account separated from application resource group

📚 Future Enhancements
Add Azure Key Vault integration for secrets management

Add Azure Monitor dashboards and alerts

Add VM extensions for configuration management

Convert to AKS cluster deployment

Add policy-as-code using Azure Policy + Terraform

Add SSH key authentication instead of password

🛠️ Built With
Terraform — Infrastructure as Code

Azure DevOps — CI/CD Pipeline

Microsoft Azure — Cloud Provider

