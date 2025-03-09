#!/bin/sh
#
# ok.sh
# Make sure the non-plan functions work
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

set -u
. ./stahp.subr

stahp_plan 8

true;  stahp_ok
false; stahp_ok
true;  stahp_ok "A passing test"
false; stahp_ok "A failing test"
stahp_pass
stahp_pass      "An unconditional pass"
stahp_fail
stahp_fail      "An unconditional fail"
