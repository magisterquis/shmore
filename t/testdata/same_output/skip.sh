#!/bin/sh
#
# skip.sh
# Test skipping things
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

. ./shmore.subr

tap_ok 0 "Before skipping"
tap_skip "Outside subtest" 2

tap_ok 0 "Before subtest"
subtest() {
        tap_skip "Inside subtest" 2
        return
}
tap_subtest "Skippy subtest" subtest

tap_ok 0 "Before end"
