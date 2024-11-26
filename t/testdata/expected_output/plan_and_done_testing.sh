#!/bin/sh
#
# plan_and_done_testing.sh
# Make sure done_testing catches when we're not according to plan.
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241105

set -e

. ./shmore.subr

tap_plan 3

tap_ok 0
tap_ok 0

tap_done_testing