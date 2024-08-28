#!/usr/bin/env python3
"""
{{cookiecutter.project_description | wordwrap(88)}}
"""

import argparse
import logging
import sys
from typing import Optional


def parse_args(argv: Optional[list] = None) -> argparse.Namespace:
    """Parse args"""

    # bool_action = (
    #     # Should be `BooleanOptionalAction` if Python >= 3.9, else the old way
    #     argparse.BooleanOptionalAction
    #     if hasattr(argparse, "BooleanOptionalAction")
    #     else "store_true"
    # )

    usage_examples: str = """examples:

        # Description

        %(prog)s <args>

    """
    descr: str = """
        {{cookiecutter.project_description}}
        """
    parser = argparse.ArgumentParser(
        description=descr,
        epilog=usage_examples,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    # parser.add_argument(
    #     "--arg",
    #     "-a",
    #     help=("arg descr"),
    #     type=str,
    # )

    parser.add_argument(
        "--verbose",
        "-v",
        action="count",
        default=0,
        dest="verbosity",
        help="Set output verbosity (-v=warning, -vv=debug)",
    )

    # if len(sys.argv) == 0:
    #     parser.print_help()
    #     sys.exit(1)

    args = parser.parse_args(argv) if argv else parser.parse_args([])

    if args.verbosity >= 2:
        log_level = logging.DEBUG
    elif args.verbosity >= 1:
        log_level = logging.INFO
    else:
        log_level = logging.WARNING

    logging.basicConfig(level=log_level)

    return args


def main(
    argv: list,
) -> None:
    """Main"""
    args = parse_args(argv)
    logging.debug("Argparse results: %s", args)
    raise SystemExit(0)


if __name__ == "__main__":
    main(sys.argv[1:])
