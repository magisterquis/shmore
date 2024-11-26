#!/bin/sh
#
# bail_functions.sh
# Test restarting after a bail
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

TAP_NOTRAP=true . ./shmore.subr

tap_reset
tap_pass
tap_fail
tap_BAIL_OUT "Temporary bail" ||:
tap_done_testing ||:

tap_reset
tap_pass
tap_fail
tap_done_testing
