#!/bin/sh
#
# funcs.t
# Put tests in functions
# By J. Stuart McMurray
# Created 20251126
# Last Modified 20251126

# Terminate on error.  Not required, but helpful.
set -e

# We can put tests in a function and not in full-blown script.  We'll not want
# tap_done_testing to be called automatically in this case.
TAP_NOTRAP=nope
. ./shmore.subr

TODAY=$(date +%A)

test_weekdays() {
        tap_reset
        tap_plan 2
        for d in Saturday Sunday; do
                tap_isnt "$TODAY" "$d" "It's not $d"
        done
        tap_done_testing
}

test_weekends() {
        tap_reset
        tap_plan 5
        for d in Monday Tuesday Wednesday Thursday Friday; do
                tap_isnt "$TODAY" "$d" "It's not $d"
        done
        tap_done_testing
}

# Bit of a contrived example, yeah :|
if [ 6 -gt "$(date +%u)" ]; then
        test_weekdays
else
        test_weekends
fi

# vim: ft=sh
