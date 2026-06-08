#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_step() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "${script_dir}/.." && pwd)"

npm_global_packages_file="${repo_root}/pkg/npm-global.txt"
if [[ -f "${npm_global_packages_file}" ]]; then
  log_step "Installing/updating global npm packages from pkg/npm-global.txt"
  mapfile -t npm_global_packages < <(grep -Ev '^\s*(#|$)' "${npm_global_packages_file}" || true)

  if (( ${#npm_global_packages[@]} > 0 )); then
    if command -v pnpm >/dev/null 2>&1; then
      log_step "Using pnpm for global npm packages with --ignore-scripts"
      pnpm add --yes --global --ignore-scripts "${npm_global_packages[@]}"
      pnpm update --yes --global --ignore-scripts "${npm_global_packages[@]}"
    else
      log_step "Skipping npm globals (pnpm not found)"
    fi
  else
    log_step "No npm global packages listed"
  fi
else
  log_step "Skipping npm globals (pkg/npm-global.txt missing)"
fi
