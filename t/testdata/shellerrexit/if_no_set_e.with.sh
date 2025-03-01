#!/bin/sh
#
# if_no_set_e.with.sh
# A broken conditional, minus set -e
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20241109

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
