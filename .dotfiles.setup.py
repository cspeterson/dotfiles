#!/usr/bin/env python3
"""
Set up selected important services beyond the dotfile, e.g. download
Audacity and Vim plugins
"""
from subprocess import call

import os
import urllib

homedir = os.path.expanduser('~')


def setup_audacity():
    """ setup_audacity """

    print('Running the audacity setup script...')
    cmd = os.path.join(homedir, '.audacity-files', 'setup.sh')
    call([cmd])

def setup_git():
    """ set git """

    print('Running the git setup script...')
    cmd = os.path.join(homedir, '.git-setup.sh')
    call([cmd])

def setup_i3():
    """ Set up i3 """

    print('Running the i3 setup script...')
    cmd = os.path.join(homedir, '.config', 'i3', 'setup.sh')
    call([cmd])

def setup_packages():
    """ Set up generally-required packages """

    print('Running the package-install script...')
    cmd = os.path.join(homedir, '.packages-install.sh')
    call([cmd])

def setup_vim():
    """ setup_vim """

    print('Running the vim setup script...')
    cmd = os.path.join(homedir, '.vim', 'setup.sh')
    call([cmd])


def main():
    """ main """
    import sys

    setups = {
        'audacity': setup_audacity,
        'git': setup_git,
        'i3': setup_i3,
        'packages': setup_packages,
        'vim': setup_vim,
    }
    all_args = sys.argv[1:]
    args = list(filter(lambda x: x in setups.keys(), all_args))
    if not all_args and not args:
        print('Specify one of ({}) or "all" to set up one or all of these '
              'services.'.format(', '.join(setups.keys())))
        sys.exit(1)

    # Set up "all" by calling every setup function
    if 'all' in [arg.lower() for arg in all_args]:
        [func() for _, func in setups.items()]
    # Set up specified services
    else:
        for setup in args:
            setups[setup]()


if __name__ == '__main__':
    main()
