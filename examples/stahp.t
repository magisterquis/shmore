#!/bin/sh
#
# stahp.t
# Use Stahp, the small TAP producer
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

# This explains how to use Stahp, the small TAP producer.  With a bit of
# squinting, it kinda follows sanity-checking a new environment for running
# some code.  Not terirbly dissimilar to what a Red Teamer might do when he
# lands on a new target...

# Normally scripts start with set -euo pipefail.
# We don't set -e here as we rely on non-zero return statuses.  It's also
# reasonably ok to use set -e and wrap everything in if statements.
# We don't use -o pipefail because dash...
set -u

. ./stahp.subr

# Make sure we have the tools to run the rest of the test.  If not, we'll use
# stahp_plan to tell the test harness we're sitting this one out.
for t in date find perl uname; do
        if ! type "$t" >/dev/null 2>&1; then
                # Don't have something we ought to, tell the harness we're
                # not doing anything else.
                stahp_plan "0 # SKIP Can't test because missing $t"
                exit 0 # Or exit 1 if this shouldn't happen.
        fi
done

# All set, note how many tests we'll run.  It's best to do this here as opposed
# to letting stahp_plan figure out how many tests we've run (perhaps with
# trap stahp_plan EXIT) to make it harder to forget a test.
stahp_plan 5

# Make sure we're still not using this in 75 years.  stahp_ok uses $?, which
# in this case is the result of the comparison [ gives us.
[ $(date +%Y) -lt 2100 ]
stahp_ok "Still in the 21st century"

# Things aren't going to go well on some known-broken OSs.  We use stahp_fail
# and stahp_pass here so as to be able to provide better messages on failure.
case "$(uname -s | perl -pe '$_=lc')" in
        emacs)   stahp_fail "OS Problem - Parentheses keys in danger"      ;;
        glados)  stahp_fail "OS Problem - Weighted companion cube missing" ;;
        windows) stahp_fail "Oh, dear :("                                  ;;
        *)       stahp_pass "OS probably fine"                             ;;
esac

# At this point, we don't really want to continue if something goes wrong.
set -e

# Strange filenames are an indication something's gone wrong.  We could also
# use stahp_ok, but with set -e we won't get that fair if perl fails.
find . -type f -exec \
        perl -e 'map{/^[ -~]+$/ or die "Illegal filename: $_"}@ARGV' {} +
stahp_pass "Filenames sane"

# Prevent own goals.  This is a handy way to bail from a script early.
[ "$(uname -n)" != "secret_computer_name" ]
stahp_pass "Not an own goal"

# ... plus other checks ...

# It's also helpful to just note how far we've gotten in a longer script with
stahp_pass "Got this far"

# vim: ft=sh
