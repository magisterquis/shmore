#!/bin/sh
#
# plan_skip_message.sh
# Make sure we can skip a test with an explanation
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

set -u
. ./stahp.subr

stahp_plan 0 "# Skip: A Test of Skippage"
