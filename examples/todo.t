#!/bin/sh
#
# todo.t
# Exmaples of TODOish things
# By J. Stuart McMurray
# Created 20251126
# Last Modified 20251126

# Terminate on error.  Not required, but helpful.
set -e

# Source shmore.
. ./shmore.subr

# Six tests, one way or the other.
tap_plan 6

# We can use tap_skip to note tests we can't run have been skipped
if [ -x ./unwritten.sh ]; then
        OUT=$(./unwritten.sh)
        tap_ok $? "./unwritten.sh ran"
        tap_is "$OUT" "Unwritten something" "Output correct"
else
        tap_skip "Don't have ./unwritten.sh" 2
fi

# TODO tests are expected to fail.  This makes a handy TODO list.
f() { tr 'A-Z' 'a-z'; }
TAP_TODO="Finish sanitization function"
tap_is "$(echo "ABC123" | f)" "abc" "Numbers removed"
TAP_TODO=
tap_is "$(echo "abc" | f)" "abc" "Lowercase allowed"

# If we really can't run a test which should be done eventually, tap_todo_skip
# is the best of both worlds.
if [ -x ./eventually.sh ]; then
        tap_ok $(./eventually.sh foo) "eventual foo" "foo eventually works"
        tap_ok $(./eventually.sh bar) "eventual bar" "bar eventually works"
else
        tap_todo_skip "Missing ./eventually.sh" 2
fi

# vim: ft=sh
