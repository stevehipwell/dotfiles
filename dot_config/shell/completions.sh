# shellcheck shell=bash

current_shell="$(detect_current_shell)"

command -v jj >/dev/null 2>&1 && eval "$(jj util completion "${current_shell}" || true)"
command -v just >/dev/null 2>&1 && eval "$(just --completions "${current_shell}" || true)"
command -v uv >/dev/null 2>&1 && eval "$(uv generate-shell-completion "${current_shell}" || true)"

if command -v git >/dev/null 2>&1; then
  if [[ "${current_shell}" = "bash" ]]; then
    # Debian (apt): provided by bash-completion package.
    if [[ -r /usr/share/bash-completion/completions/git ]]; then
      # shellcheck source=/usr/share/bash-completion/completions/git
      source /usr/share/bash-completion/completions/git
    fi
  elif [[ "${current_shell}" = "zsh" ]]; then
    # Debian zsh completion is typically available after compinit.
    autoload -Uz _git >/dev/null 2>&1 || true
  fi
fi

if command -v kubectl >/dev/null 2>&1; then
  eval "$(kubectl completion "${current_shell}" || true)"
  if [[ "${current_shell}" = "bash" ]]; then
    complete -o default -F __start_kubectl k
  elif [[ "${current_shell}" = "zsh" ]]; then
    compdef k=kubectl
  fi
fi
