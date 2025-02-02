#!/bin/sh
#
# subtest.sh
# Test subtests
# By J. Stuart McMurray
# Created 20250202
# Last Modified 20250202

set -e

. ./shmore.subr

tap_plan 1

subtest() {
        tap_plan 4
        tap_pass "A pass"
        tap_pass "Another pass"
        tap_fail "A fail"
}
tap_subtest "A subtest without enough tests" "subtest"
