#!/usr/bin/env bash

set -e

echo "::::Replace notify-osd with dunst..."
sudo apt-get remove notify-osd
sudo killall notify-osd || true
sudo apt-get install dunst
notify-send "dunst test" "Are we dunst yet?"

echo "::::Install tools and applets upon which the i3 config will rely..."
sudo apt-get install \
blueman \
fonts-font-awesome \
gnome-web-photo \
gsimplecal \
i3blocks \
i3lock \
libimage-exiftool-perl \
pasystray \
pavucontrol \
pcmanfm-qt \
shutter

echo '::::Pip install the i3ipc module for this user...'
pip3 install --user --upgrade i3ipc
echo '::::Download focus-next-visible.py from the i3ipc-python github repo...'
wget -O ~/.config/i3/focus-next-visible.py https://raw.githubusercontent.com/acrisci/i3ipc-python/master/examples/focus-next-visible.py
ls -l ~/.config/i3/focus-next-visible.py
