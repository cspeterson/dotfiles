# This file should be called by bash upon shell login at the exclusion of
# .profile. So  let's put non-gui login stuff in here ok?

# if running bash
if [ -n "${BASH_VERSION}" ]; then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
      source "${HOME}/.bashrc"
    fi
fi

# Add other bins to path if exist
bindirs=(
  "${HOME}/.bin"
  "${HOME}/.cargo/bin"
  "${HOME}/.fzf/bin"
  "${HOME}/.gems/bin"
  "${HOME}/.go/bin"
  "${HOME}/.local/bin"
  "${HOME}/bin"
  "/var/lib/flatpak/exports/bin"
  '/opt/puppetlabs/bin/'
)
for bindir in "${bindirs[@]}"; do
  if [ -d "${bindir}" ] ; then
      export PATH="${bindir}:${PATH}"
  fi
done

# Fzf
export FZF_COMPLETION_TRIGGER='~~'
FZF_COMMAND='if ([ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1); then { git ls-files; git ls-files --others --exclude-standard; }; else find 2>/dev/null; fi'
export FZF_CTRL_T_COMMAND="${FZF_COMMAND}"
export FZF_DEFAULT_COMMAND="${FZF_COMMAND}"
export FZF_DEFAULT_OPTS='-m --height 85% --reverse'

# Go
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin

# LastPass: make lastpass cli limit paste requests on clipboarded passwords
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"

# Ls: fix ls to not be wrong
export QUOTING_STYLE=literal

# Nix
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=SC1090
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

# Ruby
export GEM_HOME="$HOME/.gems"

# Vim
export EDITOR=vim
