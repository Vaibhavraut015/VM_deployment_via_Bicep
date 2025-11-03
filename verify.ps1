Param([string]$ResourceGroup = 'rg-vm-demo')
Write-Host '==> VM list' -ForegroundColor Cyan
az vm list -g $ResourceGroup -d -o table
Write-Host '==> Public IPs' -ForegroundColor Cyan
az network public-ip list -g $ResourceGroup -o table
