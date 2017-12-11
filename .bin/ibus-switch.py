#!/usr/bin/env python3

# Given a list of possible ibus engines to cycle through as args, will cycle
# through them. If current engine is not in the list, will select the first
# from the args.

def main():
    """ main """
    import os
    import sys
    import subprocess

    engines = sys.argv[1::]
    if not engines:
        print('No engines given - nothing to do', file=sys.stderr)
        sys.exit(1)

    engine_current = subprocess.getoutput('ibus engine')

    curr_idx = engines.index(engine_current)
    next_idx = (curr_idx + 1) % len(engines)

    cmd = [
        'ibus',
        'engine',
        engines[next_idx],
    ]
    subprocess.run(cmd, check=True)
    cmd = [
        'notify-send',
        'Swtiched ibus engine to "{}"'.format(engines[next_idx]),
    ]
    subprocess.run(cmd)

if __name__ == '__main__':
    main()
