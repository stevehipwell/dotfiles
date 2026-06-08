#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_step() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "${script_dir}/.." && pwd)"

go_tools_file="${repo_root}/pkg/go-tools.txt"
if command -v go >/dev/null 2>&1 && [[ -f "${go_tools_file}" ]]; then
  log_step "Installing/updating Go tools from pkg/go-tools.txt"
  mapfile -t go_tools < <(grep -Ev '^\s*(#|$)' "${go_tools_file}" || true)

  if (( ${#go_tools[@]} > 0 )); then
    for go_tool in "${go_tools[@]}"; do
      log_step "go install ${go_tool}"
      go install "${go_tool}"
    done
  else
    log_step "No Go tools listed"
  fi
else
  log_step "Skipping Go tools (go not found or pkg/go-tools.txt missing)"
fi
