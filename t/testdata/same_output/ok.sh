#!/bin/sh
#
# ok.sh
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241109

set -e

. ./shmore.subr

tap_plan 3

tap_ok 0
tap_ok 0 "Simple ok"
tap_pass "Simple pass"
