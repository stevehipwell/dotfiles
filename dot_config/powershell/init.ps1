# Init
if (Get-Command -Name mise -ErrorAction SilentlyContinue) { mise activate pwsh | Out-String | Invoke-Expression }
if (Get-Command -Name atuin -ErrorAction SilentlyContinue) { atuin init powershell | Out-String | Invoke-Expression }
if (Get-Command -Name starship -ErrorAction SilentlyContinue) { starship init powershell | Out-String | Invoke-Expression }
