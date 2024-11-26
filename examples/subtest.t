#!/bin/sh
#
# subtest.t
# Show off subtests
# By J. Stuart McMurray
# Created 20251126
# Last Modified 20251126

# Terminate on error.  Not required, but helpful.
set -e

# Source shmore.
. ./shmore.subr

# A simple non-subtest test
tap_pass "This test always passes"

# A function we'll call as a subtest
subtest() {
        # This should never fail
        :
        tap_ok "$?" ": works as true"
        
        # Nested subtests are ok, too
        subtest() {
                # Make sure none of the stooges know anything about baseball.
                for s in curly moe larry; do
                        for b in abbot costello; do
                                tap_isnt "$s" "$b" "$s isn't $b"
                        done
                done
        }
        tap_subtest "Stooges don't know baseball" "subtest"
}
tap_subtest "An excellent subtest" "subtest"

tap_cmp_ok "$(date +%Y)" "-gt" "2020" "We survived Y2K"

# vim: ft=sh
