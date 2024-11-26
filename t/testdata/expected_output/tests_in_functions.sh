#!/bin/sh
#
# tests_in_functions.sh
# Test restarting tests
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

TAP_NOTRAP=true . ./shmore.subr

test_a() {
        tap_reset

        tap_pass
        tap_fail
        subtest() {
                tap_pass
                tap_fail
        }
        tap_subtest "A Subtest" subtest

        tap_done_testing ||:
}

test_b() {
        tap_reset

        tap_fail
        tap_fail
        tap_pass

        tap_done_testing ||:
}

test_a
test_b
test_a
test_b
