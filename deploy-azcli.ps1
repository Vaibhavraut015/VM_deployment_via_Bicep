Param(
  [string]$ResourceGroup = 'rg-vm-demo',
  [string]$Location = 'eastus'
)

Write-Host '==> Ensuring Azure CLI login...' -ForegroundColor Cyan
az account show *> $null
if ($LASTEXITCODE -ne 0) { az login | Out-Null }

Write-Host "==> Creating/validating resource group: $ResourceGroup in $Location" -ForegroundColor Cyan
az group create -n $ResourceGroup -l $Location | Out-Null

Write-Host '==> Installing/validating Bicep support' -ForegroundColor Cyan
az bicep install | Out-Null

Write-Host '==> Deploying Bicep template' -ForegroundColor Cyan
az deployment group create `
  --resource-group $ResourceGroup `
  --template-file main.bicep `
  --parameters @parameters.json `
  -o table

$ip = az network public-ip list -g $ResourceGroup --query "[0].ipAddress" -o tsv
Write-Host "==> Deployment complete. Public IP: $ip" -ForegroundColor Green
