#!/bin/sh
#
# subtest.sh
# Test subtests
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_ok 0 "Test Pass" "$0" "$LINENO"
tap_ok 1 "Test Fail" "$0" "$LINENO"

subtest() {
        tap_ok 0 "Subtest Ok Pass" "$0" "$LINENO"
        tap_ok 1 "Subtest Ok Fail" "$0" "$LINENO"
        subtest() {
                tap_ok 0 "Subsubtest Ok Pass" "$0" "$LINENO"
                tap_ok 1 "Subsubtest Ok Fail" "$0" "$LINENO"
                tap_ok 1 "SubSubtest Ok Fail quietly"
                tap_ok 1
                tap_is "foo" "bar" "Subsubtest is" "$0" "$LINENO"
                tap_isnt "foo" "foo" "Subsubtest isnt" "$0" "$LINENO"
        }
        tap_subtest "Test Subsubtest" subtest "$0" "$LINENO"
}
tap_subtest "Test Subtest" "subtest" "$0" "$LINENO"

tap_ok 0 "After Pass" "$0" "$LINENO"
tap_ok 1 "After Fail" "$0" "$LINENO"

tap_done_testing;

:
