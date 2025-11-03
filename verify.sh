#!/usr/bin/env bash
set -euo pipefail
RG_NAME=${1:-rg-vm-demo}

echo "==> VM list"
az vm list -g "$RG_NAME" -d -o table

echo "==> Public IPs"
az network public-ip list -g "$RG_NAME" -o table

