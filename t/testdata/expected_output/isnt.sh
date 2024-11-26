#!/bin/sh
#
# isnt.sh
# Test got and don't want
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241105

set -e

. ./shmore.subr

tap_isnt "foo" "bar"
tap_isnt "foo" "foo"
tap_isnt "foo" "foo" "Simple isnt"
tap_isnt "foo" "foo" "Simple isnt with file and line" "$0" $LINENO

tap_done_testing
