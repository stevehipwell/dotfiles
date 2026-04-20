# shellcheck shell=bash

# Detects shell type (bash/zsh) for proper tool activation
if [[ -n "${ZSH_VERSION}" ]]; then
  CURRENT_SHELL="zsh"
elif [[ -n "${BASH_VERSION}" ]]; then
  CURRENT_SHELL="bash"
else
  CURRENT_SHELL="${SHELL##*/}"
fi

# Activate completions for tools
command -v gh >/dev/null 2>&1 && eval "$(gh completion -s "${CURRENT_SHELL}" || true)"
command -v jj >/dev/null 2>&1 && eval "$(jj util completion "${CURRENT_SHELL}" || true)"
command -v chezmoi >/dev/null 2>&1 && eval "$(chezmoi completion "${CURRENT_SHELL}" || true)"
command -v helm >/dev/null 2>&1 && eval "$(helm completion "${CURRENT_SHELL}" || true)"
command -v just >/dev/null 2>&1 && eval "$(just --completions "${CURRENT_SHELL}" || true)"
command -v kustomize >/dev/null 2>&1 && eval "$(kustomize completion "${CURRENT_SHELL}" || true)"
command -v kind >/dev/null 2>&1 && eval "$(kind completion "${CURRENT_SHELL}" || true)"
command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion "${CURRENT_SHELL}" || true)"
if command -v kubectl >/dev/null 2>&1; then
  eval "$(kubectl completion "${CURRENT_SHELL}" || true)"
  if [[ "${CURRENT_SHELL}" = "bash" ]]; then
    complete -o default -F __start_kubectl k
  elif [[ "${CURRENT_SHELL}" = "zsh" ]]; then
    compdef k=kubectl
  fi
fi

# Activate tools with shell integration
command -v mise >/dev/null 2>&1 && eval "$(mise activate "${CURRENT_SHELL}" || true)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init "${CURRENT_SHELL}" || true)"
command -v starship >/dev/null 2>&1 && eval "$(starship init "${CURRENT_SHELL}" || true)"
