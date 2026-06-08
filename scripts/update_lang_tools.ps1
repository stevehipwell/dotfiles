Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

function Write-Step {
	param([string]$Message)
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	Write-Host "[$timestamp] $Message"
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Step "Starting language tools update"

$goToolsScriptPath = Join-Path $scriptRoot "update_go_tools.ps1"
if (Test-Path -Path $goToolsScriptPath) {
	Write-Step "Running Go tools updater"
	& $goToolsScriptPath
}
else {
	Write-Step "Skipping Go tools updater (scripts/update_go_tools.ps1 missing)"
}

$npmGlobalsScriptPath = Join-Path $scriptRoot "update_npm_globals.ps1"
if (Test-Path -Path $npmGlobalsScriptPath) {
	Write-Step "Running npm globals updater"
	& $npmGlobalsScriptPath
}
else {
	Write-Step "Skipping npm globals updater (scripts/update_npm_globals.ps1 missing)"
}

Write-Step "Language tools update complete"
