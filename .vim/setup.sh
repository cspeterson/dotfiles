#!/usr/bin/env bash

if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall || echo 'Failed to install Vundle and Vim plguins. Try doing it manually.'
fi

# For previewing github-flavoured markdown
pip install --upgrade grip

echo "Please manually install the package xdotool from whatever package manager this system provides (for the markdown preview plugin)."
