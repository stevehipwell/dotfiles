$ErrorActionPreference = "Stop"

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Install-Module -Name posh-git -RequiredVersion 1.1.0 -Scope CurrentUser
Install-Module -Name PSReadLine -RequiredVersion 2.2.6 -Scope CurrentUser
