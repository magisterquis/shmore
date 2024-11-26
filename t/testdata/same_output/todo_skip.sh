#!/bin/sh
#
# todo_skip.sh
# Test tap_todo_skip
# By J. Stuart McMurray
# Created 20241114
# Last Modified 20241114

set -e

. ./shmore.subr

tap_pass "Before TODO block"

TAP_TODO="A Dummy TODO Message"
subtest() {
        tap_todo_skip "A Reason" 2
}
tap_subtest "A Subtest" subtest
TAP_TODO=

tap_pass "After TODO block"

tap_pass "A Pass"
