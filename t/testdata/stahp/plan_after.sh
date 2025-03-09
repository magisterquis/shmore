#!/bin/sh
#
# plan_after.sh
# Make sure we can put the plan at the end
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309
 
set -u
. ./stahp.subr

stahp_pass "Pass the first"
stahp_pass "Pass the second"
stahp_pass "Pass the third"

stahp_plan
