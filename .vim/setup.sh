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

if [ -d ~/.vim/bundle/YouCompleteMe ]; then
	echo "Install build tools for YCM..."
	sudo apt-get install build-essential cmake
fi
# Now compile YCM
$(cd ~/.vim/bundle/YouCompleteMe &&
	./install.py --clang-completer)

which xdotool
if [ $? -ne 0 ]; then
	echo "sudo up to install xdotool..."
	sudo apt-get install xdotool
else
	echo "Detected xdotools installed."
fi

echo 'Done.'
