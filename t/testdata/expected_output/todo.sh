#!/bin/sh
#
# todo.sh
# Test TAP_TODO
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

. ./shmore.subr

tap_pass "Before TODO block - pass";
tap_fail "Before TODO block - fail";

TAP_TODO="Do this eventually"
tap_pass "A pass"
tap_fail "A fail"
TAP_TODO=

tap_pass "After TODO block - pass";
tap_fail "After TODO block - fail";
