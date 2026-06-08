Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

function Write-Step {
	param([string]$Message)
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	Write-Host "[$timestamp] $Message"
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptRoot

$goToolsPath = Join-Path $repoRoot "pkg\go-tools.txt"
if ((Get-Command -Name go -ErrorAction SilentlyContinue) -and (Test-Path -Path $goToolsPath)) {
	Write-Step "Installing/updating Go tools from pkg/go-tools.txt"
	$goTools = Get-Content -Path $goToolsPath |
		ForEach-Object { $_.Trim() } |
		Where-Object { $_ -and -not $_.StartsWith("#") }

	if ($goTools.Count -gt 0) {
		foreach ($goTool in $goTools) {
			Write-Step "go install $goTool"
			go install $goTool
		}
	}
	else {
		Write-Step "No Go tools listed"
	}
}
else {
	Write-Step "Skipping Go tools (go not found or pkg/go-tools.txt missing)"
}
