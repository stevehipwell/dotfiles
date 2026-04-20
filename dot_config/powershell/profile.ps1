# Environment variables
$Env:XDG_CONFIG_HOME = "$HOME\.config"
$Env:XDG_DATA_HOME = "$HOME\.local\share"
$Env:EDITOR = "hx"
$Env:VISUAL = "hx"
$Env:GOPATH = "$HOME\go"
$Env:GOTELEMETRY = "local"
$Env:HELIX_CONFIG_DIR = "$HOME\.config\helix"
$Env:PATH = "$Env:GOPATH\bin;$HOME\.local\bin;$Env:PATH"
$Env:PSModulePath = "$HOME\scoop\modules;$Env:PSModulePath"

# Aliases
Set-Alias -Name h -Value hx
Set-Alias -Name zj -Value zellij
Set-Alias -Name cm -Value chezmoi
Set-Alias -Name k -Value kubectl
Set-Alias -Name docker -Value podman

# Functions
function za { zellij attach; if ($LastExitCode -ne 0) { zellij } }
function g { git @args }
function gr { go run . @args }
function gt { go test ./... @args }
function gfmt { golangci-lint --fix @args }

# Prompt

# Completions
if (Get-Command -Name gh -ErrorAction SilentlyContinue) { gh completion -s powershell | Out-String | Invoke-Expression }
if (Get-Command -Name jj -ErrorAction SilentlyContinue) { jj util completion power-shell | Out-String | Invoke-Expression }
if (Get-Command -Name chezmoi -ErrorAction SilentlyContinue) { chezmoi completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name helm -ErrorAction SilentlyContinue) { helm completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name just -ErrorAction SilentlyContinue) { just --completions powershell | Out-String | Invoke-Expression }
if (Get-Command -Name kustomize -ErrorAction SilentlyContinue) { kustomize completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name kind -ErrorAction SilentlyContinue) { kind completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name uv -ErrorAction SilentlyContinue) { uv generate-shell-completion powershell | Out-String | Invoke-Expression }
if (Get-Command -Name kubectl -ErrorAction SilentlyContinue) { kubectl completion powershell | Out-String | Invoke-Expression; Register-ArgumentCompleter -CommandName k -ScriptBlock $__kubectlCompleterBlock }

# Init
if (Get-Command -Name mise -ErrorAction SilentlyContinue) { mise activate pwsh | Out-String | Invoke-Expression }
if (Get-Command -Name atuin -ErrorAction SilentlyContinue) { atuin init powershell | Out-String | Invoke-Expression }
if (Get-Command -Name starship -ErrorAction SilentlyContinue) { starship init powershell | Out-String | Invoke-Expression }
