#!/bin/sh
#
# not_ok_no_msg.sh
# Not ok messages which don't have info
# By J. Stuart McMurray
# Created 20241114
# Last Modified 20241114

set -e

. ./shmore.subr

TAP_TODO="A Dummy TODO Skip Reason"
tap_todo_skip "A TODO Skip Reason" 2
TAP_TODO=

subtest() {
        TAP_TODO="A Dummy TODO Skip Subtest Reason"
        tap_todo_skip "A TODO Skip Subtest Reason" 2
        TAP_TODO=
}
tap_subtest "A TODO Skip Subtest" subtest
