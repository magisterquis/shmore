#!/bin/sh
#
# trap.with.sh
# Fail even when we've set a trap
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20241109

set -e

. ./shmore.subr

trap '/bin/echo kittens >/dev/null 2>&1; tap_done_testing' EXIT

tap_pass "A first passing test"
tap_pass "A second passing test"
tap_pass "A third passing test"
tap_pass "A fourth passing test"
tap_pass "A fifth passing test"
tap_pass "A sixth passing test"

for 

tap_pass "A passing test we'll never see"

# vim: ft=sh
