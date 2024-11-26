#!/bin/sh
#
# todo.sh
# Test TAP_TODO
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

. ./shmore.subr

tap_pass "Before TODO block"

TAP_TODO="A TODO Message"
tap_pass "A pass"
subtest() {
        tap_pass "A pass"
}
tap_subtest "A Subtest" subtest
TAP_TODO=

tap_pass "After TODO block";
