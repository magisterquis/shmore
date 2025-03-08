#!/bin/sh
#
# not_enough_tests.sh
# Test what happens if we forget a test
# By J. Stuart McMurray
# Created 20250222
# Last Modified 20250308

set -e

. ./shmore.subr

tap_plan 6

subtest() {
        tap_plan 4
        tap_pass "A passing subtest test"
        tap_fail "A failing subtest test" "$0" ${LINENO:-""}
}
tap_subtest "A lacking subtest" subtest "$0" ${LINENO:-""}

tap_pass "A passing test"
tap_fail "A failing test" "$0" ${LINENO:-""}
