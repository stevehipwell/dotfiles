# shellcheck shell=bash

current_shell="$(detect_current_shell)"

command -v mise >/dev/null 2>&1 && eval "$(mise activate "${current_shell}" || true)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init "${current_shell}" || true)"
command -v starship >/dev/null 2>&1 && eval "$(starship init "${current_shell}" || true)"
