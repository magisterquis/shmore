#!/bin/sh
#
# quicktstart.t
# Example with the importantest bits
# By J. Stuart McMurray
# Created 20251126
# Last Modified 20251126

# Terminate on error.  Not required, but helpful.
set -e

# Source shmore.
. ./shmore.subr

# Note how many tests will be run.  Not strictly necessary but prevents missing
# or extra tests as well as makes prove a bit less boring to watch.
tap_plan 3

# Simplest test is to make sure a previous command worked.
/bin/echo "It worked" >/dev/null
tap_ok $? "Echo succeeded"

# More useful is comparing what we got and what we want.
GOT=$(echo "It worked")
WANT="It worked"
tap_is "$GOT" "$WANT" "Echo echoed properly"

# If we have perl, we can also test against a regex
if which perl >/dev/null 2>&1; then
        tap_like "$(date)" '20\d{2}$' "Still in the 21st century"
else
        # Or we can use tap_skip to note we skipped a test
        tap_skip "Missing perl" 1
fi

# vim: ft=sh
