#!/bin/sh
#
# done_testing.sh
# Make sure we don't need to know how many tests we'll run ahead of time.
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241105

set -e

. ./shmore.subr

tap_ok 0

tap_done_testing
