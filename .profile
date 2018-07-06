# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# i.e. this script runs for graphical logins since .bash_profile is present
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# If running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bash_profile" ]; then
	. "$HOME/.bash_profile"
    fi
fi

# Set up screen layout
if [ -f "$HOME/.screenlayout/screenlayout" ]; then
  "$HOME/.screenlayout/screenlayout"
fi
