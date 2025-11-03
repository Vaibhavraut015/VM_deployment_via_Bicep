# Azure VM Deployment Project (Bicep + Azure CLI)

A hands-on project to deploy a **production-ready Linux VM** on Azure using **Bicep** and **Azure CLI**, including networking, NSG, and public IP. This is tailored for portfolio use and interview demos.

## What you get
- `main.bicep`: Declarative infrastructure for VM, VNet, Subnet, NSG, NIC, and Public IP
- `parameters.json`: Sample parameters for safe, repeatable deployments
- `deploy-azcli.sh`: Bash script to deploy using Azure CLI
- `deploy-azcli.ps1`: PowerShell script (using Azure CLI) for Windows users
- `verify.sh` / `verify.ps1`: Quick validation scripts
- `cleanup.sh` / `cleanup.ps1`: Teardown scripts to avoid ongoing cost
- `Project-Report-VM-Deployment.docx`: Fill-in project report template for your portfolio

> **Default OS**: Ubuntu 22.04 LTS (Gen2) with SSH key authentication (password login disabled).

---

## Prerequisites
- Azure subscription
- **Azure CLI** (2.58+). Install: https://learn.microsoft.com/cli/azure/install-azure-cli
- Ensure Bicep is available via CLI: `az bicep install` (one time)
- A resource group name (e.g., `rg-vm-demo`) and location (e.g., `eastus`)
- An SSH public key on your machine (usually at `~/.ssh/id_rsa.pub` or `~/.ssh/id_ed25519.pub`)

---

## Quick Start

```bash
# 1) Login and select subscription
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

# 2) Create a resource group
az group create -n rg-vm-demo -l eastus

# 3) (One time) Ensure Bicep is available
az bicep install

# 4) Update parameters.json with your adminUsername and adminPublicKey

# 5) Deploy
az deployment group create   --resource-group rg-vm-demo   --template-file main.bicep   --parameters @parameters.json

# 6) Get public IP
az network public-ip list -g rg-vm-demo --query "[0].ipAddress" -o tsv

# 7) SSH in (example)
ssh <adminUsername>@<PublicIP>
```

---

## Architecture
- **VNet**: 10.0.0.0/16
- **Subnet**: 10.0.1.0/24
- **NSG**: Allows inbound SSH (22/tcp) from `allowSshFrom` CIDR (default `0.0.0.0/0` — change to your IP for security)
- **Public IP**: Standard, Static
- **NIC**: Attached to subnet + NSG
- **VM**: Ubuntu 22.04 LTS (Gen2), Standard_B1s by default, SSH key only

---

## Cost Notes
- Using `Standard_B1s` + `StandardSSD_LRS` keeps cost low for demos.
- Stop or delete the VM when not in use. Use `cleanup.sh`/`cleanup.ps1` to remove the entire stack.

---

## Windows VM Option
If you prefer Windows Server (with RDP/3389), you can:
- Change the image reference in `main.bicep` to Windows
- Add an NSG rule for 3389 from limited IPs
- Switch to an admin password (or Azure AD login) per your policy

Reach out if you want me to generate a Windows-specific variant for you.

---

## Files & Commands Reference
```text
azure-vm-deployment-project/
├─ main.bicep
├─ parameters.json
├─ deploy-azcli.sh
├─ deploy-azcli.ps1
├─ verify.sh
├─ verify.ps1
├─ cleanup.sh
├─ cleanup.ps1
└─ Project-Report-VM-Deployment.docx
```

**Happy building!**
