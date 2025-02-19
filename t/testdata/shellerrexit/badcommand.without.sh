#!/bin/sh
#
# badcommand.without.sh
# badcommand.with.sh without shmore
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20241109

set -e

. ./shmore.subr

# Something to trigger a -e exit.
r99() { return 99; }

tap_pass
tap_pass
tap_pass
tap_pass
tap_pass
tap_pass
tap_pass
tap_pass "Pass 8"

r99

tap_pass "Never seen"
tap_pass

# vim: ft=sh
