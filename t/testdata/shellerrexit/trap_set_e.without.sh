#!/bin/sh
#
# trap.with.sh
# Return the right exit code on a -e fail, even with a trap
# By J. Stuart McMurray
# Created 20250430
# Last Modified 20250430

set -e



trap '/bin/echo kittens >/dev/null 2>&1' EXIT



/bin/sh -c 'exit 12'

# vim: ft=sh
