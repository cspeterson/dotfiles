#!/usr/bin/env python3
"""
Icinga2/Nagios plugin which...
{{cookiecutter.project_description | wordwrap(88)}}
"""

import argparse
import logging
import sys
from typing import Generator, Optional

import nagiosplugin  # type:ignore

from {{cookiecutter.resource_class_name | lower}} import {{cookiecutter.resource_class_name}}


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

        # For more on how to set warning and critical ranges, see Nagios
        # Plugin Development Guidelines:
        #
        # https://nagios-plugins.org/doc/guidelines.html#THRESHOLDFORMAT

    """
    descr: str = """
        Icinga2/Nagios plugin which {{cookiecutter.project_description}}
        """
    parser = argparse.ArgumentParser(
        description=descr,
        epilog=usage_examples,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "--critical",
        "-c",
        help=("Critical range for ..."),
        type=str,
    )

    parser.add_argument(
        "--verbose",
        "-v",
        action="count",
        default=0,
        dest="verbosity",
        help="Set output verbosity (-v=warning, -vv=debug)",
    )

    parser.add_argument(
        "--warning",
        "-w",
        help=("Warning range for ..."),
        type=str,
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


@nagiosplugin.guarded
def main(
    argv: list,
) -> None:
    """Main"""
    args = parse_args(argv)
    logging.debug("Argparse results: %s", args)

    some_resource = SomeResource()
    context = nagiosplugin.ScalarContext(
        "context",
        warning=args.warning,
        critical=args.critical,
    )
    check = nagiosplugin.Check(some_resource, context)
    check.main(args.verbosity)


if __name__ == "__main__":
    main(sys.argv[1:])
