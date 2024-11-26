#!/bin/sh
#
# todo.sh
# Make sure todoish output goes to the right place
# By J. Stuart McMurray
# Created 20241126
# Last Modified 20241126

set -e

. ./shmore.subr

TAP_TODO="Checking output"
tap_is "kittens" "moose" "Output location"
TAP_TODO=

tap_skip "A skip" 2

tap_todo_skip "A todo plus a skip" 2
