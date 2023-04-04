$ErrorActionPreference = "Stop"

New-Item -ItemType SymbolicLink -Target "$([Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile))\.config\profile.ps1" -Path "$([Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments))\PowerShell\profile.ps1"
