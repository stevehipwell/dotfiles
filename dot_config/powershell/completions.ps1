# Completions
if (Get-Command -Name jj -ErrorAction SilentlyContinue) { jj util completion power-shell | Out-String | Invoke-Expression }
if (Get-Command -Name just -ErrorAction SilentlyContinue) { just --completions powershell | Out-String | Invoke-Expression }
if (Get-Command -Name uv -ErrorAction SilentlyContinue) { uv generate-shell-completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name kubectl -ErrorAction SilentlyContinue) { kubectl completion powershell | Out-String | Invoke-Expression; Register-ArgumentCompleter -CommandName k -ScriptBlock $__kubectlCompleterBlock }
