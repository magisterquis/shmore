#!/bin/sh
#
# bail.sh
# Test bailing out
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241125

set -e

. ./shmore.subr

tap_pass
subtest() {
        tap_BAIL_OUT Test test test
}
tap_subtest "Bailing Subtest" subtest
tap_pass
tap_done_testing
