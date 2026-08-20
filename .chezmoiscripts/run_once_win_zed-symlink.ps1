Set-StrictMode -Version latest
$ErrorActionPreference="Stop"

New-Item -ItemType SymbolicLink -Path "$env:APPDATA\zed" -Value "$env:USERPROFILE\.config\zed" -Force
