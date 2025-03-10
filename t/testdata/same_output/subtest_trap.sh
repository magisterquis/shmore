#!/bin/sh
#
# subtest_trap.sh
# Make sure a trap calling tap_done_testing in a subtest works
# By J. Stuart McMurray
# Created 20250310
# Last Modified 20250310


. ./t/t.subr
. ./shmore.subr

tap_plan 1

subtest() {
        . ./t/t.subr
        trap 'tap_done_testing' EXIT
        tap_plan 2
        tap_pass "A Pass"
        tap_fail "A Fail" "$0" ${LINENO:-""}
}
tap_subtest "A Subtest" 'subtest' "$0" ${LINENO:-""}
