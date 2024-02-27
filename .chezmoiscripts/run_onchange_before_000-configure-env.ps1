$ErrorActionPreference = "Stop"

[Environment]::SetEnvironmentVariable('AWS_REGION', '_', 'User')
[Environment]::SetEnvironmentVariable('AWS_PROFILE', '_', 'User')
[Environment]::SetEnvironmentVariable('COMPOSE_DOCKER_CLI_BUILD', '1', 'User')
[Environment]::SetEnvironmentVariable('DOCKER_BUILDKIT', '1', 'User')
[Environment]::SetEnvironmentVariable('EDITOR', 'code --wait', 'User')
[Environment]::SetEnvironmentVariable('GHCR_TOKEN', '_', 'User')
[Environment]::SetEnvironmentVariable('SAML2AWS_USERNAME', '_', 'User')
[Environment]::SetEnvironmentVariable('VAULT_ADDR', '_', 'User')
[Environment]::SetEnvironmentVariable('VAULT_TOKEN', '_', 'User')
[Environment]::SetEnvironmentVariable('WSLENV', 'AWS_REGION/u:AWS_PROFILE/u:GHCR_TOKEN/u:SAML2AWS_USERNAME/u:VAULT_ADDR/u:VAULT_TOKEN/u', 'User')
