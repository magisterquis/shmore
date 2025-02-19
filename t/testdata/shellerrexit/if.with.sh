#!/bin/sh
#
# if.with.sh
# A broken conditional
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20241109

set -e

. ./shmore.subr

tap_plan 10

tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"

if

# vim: ft=sh
