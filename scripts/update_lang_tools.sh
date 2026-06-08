#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_step() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

log_step "Starting language tools update"

go_tools_script="${script_dir}/update_go_tools.sh"
if [[ -f "${go_tools_script}" ]]; then
  log_step "Running Go tools updater"
  bash "${go_tools_script}"
else
  log_step "Skipping Go tools updater (scripts/update_go_tools.sh missing)"
fi

npm_globals_script="${script_dir}/update_npm_globals.sh"
if [[ -f "${npm_globals_script}" ]]; then
  log_step "Running npm globals updater"
  bash "${npm_globals_script}"
else
  log_step "Skipping npm globals updater (scripts/update_npm_globals.sh missing)"
fi

log_step "Language tools update complete"
