# This file should be called by bash upon shell login at the exclusion of
# .profile. So  let's put non-gui login stuff in here ok?

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      source "$HOME/.bashrc"
    fi
fi

# Add other bins to path if exist
bindirs=(
"$HOME/.bin"
"$HOME/.cargo/bin"
"$HOME/.fzf/bin"
"$HOME/.gems/bin"
"$HOME/.go/bin"
"$HOME/.local/bin"
"$HOME/bin"
)
for bindir in "${bindirs[@]}"; do
  if [ -d $bindir ] ; then
      export PATH="$bindir:$PATH"
  fi
done

# Fzf
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_COMMAND='find'
export FZF_DEFAULT_COMMAND='find'
export FZF_DEFAULT_OPTS='-m --height 85% --reverse'

# Go
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin

# LastPass: make lastpass cli limit paste requests on clipboarded passwords
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"

# Ls: fix ls to not be wrong
export QUOTING_STYLE=literal

# Ruby
export GEM_HOME="$HOME/.gems"

# Vim
export EDITOR=vim
