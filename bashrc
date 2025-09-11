for file in ~/.{path,exports,bash_prompt,functions,aliases,extra}; do
  [[ -r "${file}" ]] && [[ -f "${file}" ]] && source "${file}"
done
unset file

[[ -z "${PS1}" ]] && return # exit early if not interactive
shopt -s checkwinsize       # updates size of terminal after commands
shopt -s histappend

# makes less work on things like tarballs and images
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
