#!/bin/sh
#
# is.sh
# Test got and want
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241105

set -e

. ./shmore.subr

tap_is "foo" "foo"
tap_is "foo" "bar"
tap_is "foo" "bar" "Simple is"
tap_is "foo" "bar" "Simple is with file and line" "$0" $LINENO

tap_done_testing
