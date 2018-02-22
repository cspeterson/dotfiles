# This file should be called by bash upon shell login at the exclusion of
# .profile. So  let's put non-gui login stuff in here ok?

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private hidden bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# Make lastpass cli limit paste requests on clipboarded passwords
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"

