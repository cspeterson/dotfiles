#!/usr/bin/env bash

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	echo 'Install Vundle...'
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo 'Installing vim plugins...'
vim +PluginInstall +qall || echo 'Failed to install Vundle and Vim plguins. Try doing it manually.'

# For previewing github-flavoured markdown
echo 'Installing grip with pip...'
pip install --user --upgrade grip >/dev/null

# Everything I use fits within this list of package managers
# This is a dumb lazy way of doing this but, again, I know which platforms I use
pkg_mans=('apt-get' 'yum' 'dnf')
for test_pkg_man in ${pkg_mans[@]}; do
	which $test_pkg_man
	if [ $? -eq 0 ]; then
		pkg_man=$test_pkg_man
		break
	fi
done
if [ -z ${pkg_man+x} ]; then
	echo "Did not find either apt-get, yum, or dnf package managers. What happen?"
	echo "Please manually install the package xdotool from whatever package manager this system provides (for the markdown preview plugin)."
else
	which xdotool
	if [ $? -ne 0 ]; then
		echo "sudo up to install xdotool..."
		sudo $pkg_man install xdotool
	else
		echo "Detected xdotools installed."
	fi
fi

echo 'Done.'
