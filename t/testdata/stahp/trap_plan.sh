#!/bin/sh
#
# trap_plan.sh
# Run stahp_plan in an EXIT trap
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

set -u
. ./stahp.subr

# This isn't a very good idea...
trap stahp_plan EXIT

true;  stahp_ok "A passing test"
false; stahp_ok "A failing test"
stahp_pass      "An unconditional pass"
stahp_fail      "An unconditional fail"
