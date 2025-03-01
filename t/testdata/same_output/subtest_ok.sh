#!/bin/sh
#
# subtest_ok.sh
# Test a very simple subtest
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20250301

set -e

. ./shmore.subr

tap_ok 0
tap_ok 0 "Simple ok"

subtest() {
        tap_ok 0
        tap_ok 0 "Simple subtest test"

        subtest() {
                tap_plan 2
                tap_ok 0
                tap_ok 0 "Simple subsubtest test"
        }
        tap_subtest "Simple subsubtest" subtest
}
tap_subtest "Simple subtest" subtest

tap_subtest "Functionless subtest" "tap_pass 'A Pass'; tap_ok 0 'An ok'"

tap_ok 0 "After subtest"

tap_done_testing
