#!/bin/sh
#
# if.with.sh
# A broken conditional
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20250301

set -e

# Don't bother if this is Bash under verision 4.1, because it won't report 
# errors to $? properly.  Looking at you, macOS.
# 
# https://git.savannah.gnu.org/cgit/bash.git/tree/CHANGES#n4470
# The ERR and EXIT traps now see a non-zero value for $? when a parser
#     error after set -e has been enabled causes the shell to exit.
if [ -n "$BASH_VERSION" ] && ( [ 4 -gt ${BASH_VERSINFO[0]} ] ||
        [ 4 -eq ${BASH_VERSINFO[0]} -a 0 -eq ${BASH_VERSINFO[1]} ] ); then
        echo SKIPSKIP
        exit 0
fi

. ./shmore.subr

tap_plan 10

tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"
tap_pass "A passing test"

if

# vim: ft=sh
