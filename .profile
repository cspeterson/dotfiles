# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

# Pulseaudio stuff so bluetooth headphones will work
# I tried putting them into ~/.config/pulse/default.pa but it just made Pulse
# break, so here we are
start-pulseaudio-x11
pacmd load-module module-bluetooth-policy
pacmd load-module module-bluetooth-discover
