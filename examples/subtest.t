#!/bin/sh
#
# subtest.t
# Show off subtests
# By J. Stuart McMurray
# Created 20241126
# Last Modified 20250308

# Terminate on error.  Not required, but helpful.  Even better is
# set -euo pipefail, but dash doesn't have $LINENO.
set -e

# Source shmore.
. ./shmore.subr

# A simple non-subtest test
tap_pass "This test always passes" "$0" $LINENO

# A function we'll call as a subtest
subtest() {
        # This should never fail
        :
        tap_ok "$?" ": works as true" "$0" $LINENO
        
        # Nested subtests are ok, too
        subtest() {
                # Make sure none of the stooges know anything about baseball.
                for s in curly moe larry; do
                        for b in abbot costello; do
                                tap_isnt "$s" "$b" "$s isn't $b" "$0" $LINENO
                        done
                done
        }
        tap_subtest "Stooges don't know baseball" "subtest" "$0" $LINENO
}
tap_subtest "An excellent subtest" "subtest" "$0" $LINENO

# A subtest we'll not need after all
subtest() {
        tap_plan 0 "Skipping as an example"; return
        tap_pass "This isn't actually needed"
}
tap_subtest "A skipped subtest" "subtest" "$0" $LINENO

tap_cmp_ok "$(date +%Y)" "-gt" "2020" "We survived Y2K" "$0" $LINENO

# vim: ft=sh
