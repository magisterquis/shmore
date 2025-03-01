#!/bin/sh
#
# echo.sh
# Test script skip_all
# By J. Stuart McMurray
# Created 20250301
# Last Modified 20250301

set -e

. ./shmore.subr

tap_plan 0 "A script skip_all test"; exit

tap_pass "A never-reached pass"
