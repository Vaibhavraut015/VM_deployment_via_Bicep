#!/usr/bin/env bash
set -euo pipefail

RG_NAME=${1:-rg-vm-demo}
LOCATION=${2:-eastus}

echo "==> Ensuring you are logged in..."
az account show >/dev/null 2>&1 || az login

echo "==> Setting up resource group: $RG_NAME in $LOCATION"
az group create -n "$RG_NAME" -l "$LOCATION" >/dev/null

echo "==> Installing/Validating Bicep CLI integration"
az bicep install >/dev/null

echo "==> Deploying Bicep template"
az deployment group create   --resource-group "$RG_NAME"   --template-file main.bicep   --parameters @parameters.json   -o table

IP=$(az network public-ip list -g "$RG_NAME" --query "[0].ipAddress" -o tsv)
echo "==> Deployment complete. Public IP: $IP"

