#!/usr/bin/env bash

plugins=(
'http://wiki.audacityteam.org/w/images/7/75/Noisegate.ny'
)

echo "Installing Audacity plugins if not installed..."
for plugin in ${plugins[@]}; do
	filename=$(basename "${plugin}")
	filepath=".audacity-files/plug-ins/${filename}"
	if [ ! -f "${filepath}" ]; then
		echo "Installing plugin ${filename}..."
		wget -O "${filepath}" "${plugin}" >/dev/null
	else
		echo "Skipping plugin ${filename}; already downloaded."
	fi
done
