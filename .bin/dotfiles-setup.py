#!/usr/bin/env python3
"""
Set up selected important services beyond the dotfile, e.g. download
Audacity and Vim plugins, etc
"""

def main():
    """ main """
    import sys
    import os
    import urllib

    from subprocess import call

    homedir = os.path.expanduser('~')

    setups = [
        'audacity',
        'gimp',
        'git',
        'i3',
        'packages',
        'vim',
    ]
    all_args = sys.argv[1:]
    args = list(filter(lambda x: x in setups, all_args))
    if not all_args and not args:
        print('Specify one of ({}) or "all" to set up one or all of these '
              'services.'.format(', '.join(setups)))
        sys.exit(1)

    # Set up "all" by calling every setup function
    if 'all' in [arg.lower() for arg in all_args]:
        [func() for _, func in setups.items()]
    # Set up specified services
    else:
        for setup in args:
            cmd = os.path.join(homedir, '.bin', 'setup-{}'.format(setup))
            call([cmd])


if __name__ == '__main__':
    main()
