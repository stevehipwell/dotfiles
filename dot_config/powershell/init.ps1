# Init
if (Get-Command -Name fnm -ErrorAction SilentlyContinue) { fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression }
if (Get-Command -Name atuin -ErrorAction SilentlyContinue) { atuin init powershell | Out-String | Invoke-Expression }
if (Get-Command -Name starship -ErrorAction SilentlyContinue) { starship init powershell | Out-String | Invoke-Expression }
