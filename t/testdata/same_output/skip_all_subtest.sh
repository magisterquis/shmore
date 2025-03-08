#!/bin/sh
#
# echo.sh
# Test script skip_all
# By J. Stuart McMurray
# Created 20250301
# Last Modified 20250308

set -e

. ./shmore.subr

tap_plan 8

tap_pass "Pre-subtest pass 1"
tap_pass "Pre-subtest pass 2"
tap_pass "Pre-subtest pass 3"
tap_pass "Pre-subtest pass 4"
tap_pass "Pre-subtest pass 5"
tap_pass "Pre-subtest pass 6"

subtest() {
        tap_plan 0 "A subtest skip_all test"; return
        tap_pass "A never-reached subtest pass"
}
tap_subtest "A skippy subtest" subtest "$0" ${LINENO:-""}




tap_pass "A post-subtest pass"
