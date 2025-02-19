#!/bin/sh
#
# badcommand.with.sh
# Fail after getting a bad command, for exit status check
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20241109

set -e

. ./shmore.subr

# Something to trigger a -e exit.
r99() { return 99; }










r99




# vim: ft=sh
