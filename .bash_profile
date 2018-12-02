# This file should be called by bash upon shell login at the exclusion of
# .profile. So  let's put non-gui login stuff in here ok?

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Fix ls to not be wrong
export QUOTING_STYLE=literal

# Go
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin

# Ruby
export GEM_HOME="$HOME/.gems"

# Add other bins to path if exist
bindirs=(
"$HOME/.bin"
"$HOME/.cargo/bin"
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

# Make lastpass cli limit paste requests on clipboarded passwords
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"
