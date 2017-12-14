#!/usr/bin/env bash

# ENVVARS
export TERMINAL=terminator
# Vim ftw
export EDITOR=vim
# Lastpass cli - make clipboard selections time out
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"

#Compose key: right alt
setxkbmap -option compose:ralt
# Load custom xmodmap (for making Capslock act as l_ctrl)
xmodmap ~/.Xmodmap
# Set screen timeout
xset dpms 600
