#!/bin/sh
#
# tap_todo_skip_reversed.sh
# Test TAP_TODO
# By J. Stuart McMurray
# Created 20250803
# Last Modified 20250804

. ./t/t.subr
. ./shmore.subr


set +e
tap_todo_skip 2 "A reason in the wrong place"
set -e

subtest() {
        set +e
        tap_todo_skip 2 "A reason in the wrong place"
        set -e
        tap_todo_skip "A reason in the correct place" 2
}
tap_subtest "A Subtest" "subtest" 'todo_skip_reversed_filename' 21

tap_todo_skip "A reason in the correct place" 2
