#!/usr/bin/env bash
set -euo pipefail
RG_NAME=${1:-rg-vm-demo}

echo "==> Deleting resource group: $RG_NAME"
az group delete -n "$RG_NAME" --yes --no-wait

echo "Cleanup initiated. Resources will be deleted asynchronously."
