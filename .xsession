#!/usr/bin/env bash

# ENVVARS
export TERMINAL=kitty
# Vim ftw
export EDITOR=vim
# Lastpass cli - make clipboard selections time out
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"

#Compose key: right alt
setxkbmap -option compose:ralt

# Always load custom xmodmap (for making Capslock act as l_ctrl)
xmodmap ~/.Xmodmap

# Sometimes load custom modmap which rearranges the keys on my laptop keyboard
# add to sudoers: `<username> ALL=(root) NOPASSWD: /usr/sbin/dmidecode -s system-product-name`
system_model=$(/usr/bin/sudo /usr/sbin/dmidecode -s system-product-name) || true
if [ "${system_model}" == "XPS 13 7390 2-in-1" ]; then
  xmodmap ~/.Xmodmap.xps13
fi

# Set screen timeout
xset dpms 600
