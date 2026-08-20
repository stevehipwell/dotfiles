Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

function Write-Step {
	param([string]$Message)
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	Write-Host "[$timestamp] $Message"
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptRoot

$npmGlobalPackagesPath = Join-Path $repoRoot "pkg\npm-global.txt"
if (Test-Path -Path $npmGlobalPackagesPath) {
	Write-Step "Installing/updating global npm packages from pkg/npm-global.txt"
	$npmGlobalPackages = Get-Content -Path $npmGlobalPackagesPath |
		ForEach-Object { $_.Trim() } |
		Where-Object { $_ -and -not $_.StartsWith("#") }

	if ($npmGlobalPackages.Count -gt 0) {
		if (Get-Command -Name npm -ErrorAction SilentlyContinue) {
			Write-Step "Using npm for global packages with --ignore-scripts"
			npm install --global --ignore-scripts @npmGlobalPackages
			npm update --global --ignore-scripts @npmGlobalPackages
		}
		else {
			Write-Step "Skipping npm globals (npm not found)"
		}
	}
	else {
		Write-Step "No npm global packages listed"
	}
}
else {
	Write-Step "Skipping npm globals (pkg/npm-global.txt missing)"
}
