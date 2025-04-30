#!/bin/sh
#
# trap.with.sh
# trap.with.sh without shmore
# By J. Stuart McMurray
# Created 20250430
# Last Modified 20250430

set -e

. ./shmore.subr

trap '/bin/echo kittens >/dev/null 2>&1; tap_done_testing' EXIT

tap_pass "A pass"

/bin/sh -c 'exit 12'

# vim: ft=sh
