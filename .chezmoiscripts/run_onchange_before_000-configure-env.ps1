$ErrorActionPreference = "Stop"

[Environment]::SetEnvironmentVariable('AWS_DEFAULT_REGION', '', 'User')
[Environment]::SetEnvironmentVariable('AWS_PROFILE', '', 'User')
[Environment]::SetEnvironmentVariable('COMPOSE_DOCKER_CLI_BUILD', '1', 'User')
[Environment]::SetEnvironmentVariable('DOCKER_BUILDKIT', '1', 'User')
[Environment]::SetEnvironmentVariable('EDITOR', 'code --wait', 'User')
[Environment]::SetEnvironmentVariable('GHCR_TOKEN', '', 'User')
[Environment]::SetEnvironmentVariable('SAML2AWS_USERNAME', '', 'User')
[Environment]::SetEnvironmentVariable('VAULT_ADDR', '', 'User')
[Environment]::SetEnvironmentVariable('VAULT_TOKEN', '', 'User')
[Environment]::SetEnvironmentVariable('WSLENV', 'AWS_DEFAULT_REGION/u:AWS_PROFILE/u:GHCR_TOKEN/u:SAML2AWS_USERNAME/u:VAULT_ADDR/u:VAULT_TOKEN/u', 'User')