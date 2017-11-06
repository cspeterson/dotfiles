#!/usr/bin/env bash
set -e

date '+%Y-%m-%d %I:%M:%S'
[ -z "${BLOCK_BUTTON}" ] || gsimplecal &
