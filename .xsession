#!/usr/bin/env bash

# ENVVARS
export TERMINAL=terminator


#Compose key: right alt
setxkbmap -option compose:ralt
# Load custom xmodmap (for making Capslock act as l_ctrl)
xmodmap ~/.Xmodmap
# Set screen timeout
xset dpms 600
