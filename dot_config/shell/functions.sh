# shellcheck shell=bash

# Detect current shell type for completion/tool activation.
detect_current_shell() {
	if [[ -n "${ZSH_VERSION}" ]]; then
		printf '%s\n' "zsh"
	elif [[ -n "${BASH_VERSION}" ]]; then
		printf '%s\n' "bash"
	else
		printf '%s\n' "${SHELL##*/}"
	fi
}
