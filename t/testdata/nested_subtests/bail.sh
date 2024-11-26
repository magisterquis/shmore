#!/bin/sh
#
# bail.sh
# Test bailing from a deep subtest
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

. ./shmore.subr

tap_pass
tap_fail
subtest() {
        tap_pass
        tap_fail
        subtest() {
                tap_pass
                tap_fail
                subtest() {
                        tap_pass
                        tap_fail
                        tap_BAIL_OUT "Deep nesting"
                        tap_pass
                        tap_fail
                }
                tap_subtest "L3 Subtest" subtest
                tap_pass
                tap_fail
        }
        tap_subtest "L2 Subtest" subtest
        tap_pass
        tap_fail
}
tap_subtest "L1 Subtest" subtest
tap_pass
tap_fail
