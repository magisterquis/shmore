#!/bin/sh
#
# bail_subshell.sh
# Test bailing out from a test in a subshell
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_pass
subtest() {
        tap_BAIL_OUT Test test test
}
tap_subtest "Bailing Subtest" subtest
tap_pass
tap_done_testing
