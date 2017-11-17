# My dotfiles

This is my home directory. There are many like it, but this one is mine.

## Getting started

Here is how to get this back up and installed on a new machine

### Prerequisites

* Ubuntu (or maybe any Debian-based distro?)
* Bash
* Git

I'm pretty sure that's it, actually.

### Installing the dotfiles

First look in .gitignore and back up any files in your homedir that this overwrites that you care about.
Then you'll need to clone this repo to an empty directory and then move the files into your home

```
~$ mkdir clonehere
~$ cd clonehere
~/clonehere$ git clone <repo uri> .
# This could overwrite things! So back things up or whatever.
~/clonehere$ rsync -a ./* ~/
```

### Run setups

Some (all?) of these different configs rely upon external plugins/utilities/whatever which are not included in this repo.

So what is included are different setup scripts. With the repo files in-place, one could then run
```
# Set up for all the things in this repo
~/.dotfiles.setup.py all
```
or
```
# Set up an individual component.
~/.dotfiles.setup.py
# <outputs list of setup options>
~/.dotfiles.setup.py <specific setup from the list>
```
