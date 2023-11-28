# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Add other bins to path if exist
bindirs=(
  "${HOME}/.cargo/bin"
  "${HOME}/.fzf/bin"
  "${HOME}/.gems/bin"
  "${HOME}/.go/bin"
  "${HOME}/.local/bin"
  "${HOME}/.node_user/node_modules/.bin/"
  "${HOME}/bin"
  '/opt/puppetlabs/bin/'
  '/var/lib/flatpak/exports/bin'
  "${HOME}/.bin" # Add this last pls
)
for bindir in "${bindirs[@]}"; do
  if [ -d "${bindir}" ] ; then
      export PATH="${bindir}:${PATH}"
  fi
done

# Usage-related bash settings
if [ -f ~/.bash_settings ]; then
	source ~/.bash_settings
fi

# Git things
# Source from home if possible else assume an Ubuntu system install. Then, finally, CentOS.
{ [ -f "${HOME}.git-completion.bash" ] && source "${HOME}.git-completion.bash"; } ||
  { [ -f /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git; }
{ [ -f "${HOME}/.git-prompt.sh" ] && source "${HOME}/.git-prompt.sh"; } ||
  { [ -f /etc/bash_completion.d/git-prompt ] && source /etc/bash_completion.d/git-prompt; } ||
    { [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && source /usr/share/git-core/contrib/completion/git-prompt.sh; }

# Prompty things (should come after git as we are using git prompt)
if [ -f ~/.bash_ps1 ]; then
	source ~/.bash_ps1
fi

# Bash aliases etc specific to this machine/site
if [ -f ~/.bash_local ]; then
	source ~/.bash_local
fi

# Fzf
# Source from home if possible else assume an Ubuntu system install
{ [ -f "${HOME}/.fzf/shell/completion.bash" ] && source "${HOME}/.fzf/shell/completion.bash"; } ||
  { [ -f '/usr/share/bash-completion/completions/fzf' ] && source '/usr/share/bash-completion/completions/fzf' 2> /dev/null; }
{ [ -f "${HOME}/.fzf/shell/key-bindings.bash" ] && source "${HOME}/.fzf/shell/key-bindings.bash"; } ||
  { [ -f '/usr/share/doc/fzf/examples/key-bindings.bash' ] && source '/usr/share/doc/fzf/examples/key-bindings.bash'; }


# Collections
if [ -d "${HOME}/.bash.d" ]; then
  for f in "${HOME}/.bash.d"/*; do
    source "${f}"
  done
fi

# Collections
if [ -d "${HOME}/.bash.local.d" ]; then
  for f in "${HOME}/.bash.local.d"/*; do
    if [ -f "${f}" ]; then
      source "${f}"
    fi
  done
fi

if [ -d "${HOME}/.bash_completion.d" ]; then
  for f in "${HOME}/.bash_completion.d"/*; do
    source "${f}"
  done
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi
