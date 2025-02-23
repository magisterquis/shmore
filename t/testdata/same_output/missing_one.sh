#!/bin/sh
#
# missing_one.sh
# Make sure done_testing catches us if we only miss one test
# By J. Stuart McMurray
# Created 20250222
# Last Modified 20250222

set -e

. ./shmore.subr

tap_plan 4;

tap_fail "A fail" "$0" $LINENO
tap_pass "A pass"
subtest() {
        tap_plan 6;
        tap_pass "Pass one";
        tap_pass "Pass two";
        tap_pass "Pass three";
        tap_pass "Pass four";
        tap_pass "Pass five";
}
tap_subtest "A subtest" subtest "$0" $LINENO
