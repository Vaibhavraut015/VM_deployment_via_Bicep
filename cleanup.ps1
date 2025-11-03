Param([string]$ResourceGroup = 'rg-vm-demo')
Write-Host "==> Deleting resource group: $ResourceGroup" -ForegroundColor Yellow
az group delete -n $ResourceGroup --yes --no-wait
Write-Host 'Cleanup initiated. Resources will be deleted asynchronously.' -ForegroundColor Green
