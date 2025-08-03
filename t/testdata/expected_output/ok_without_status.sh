#!/bin/sh
#
# ok_without_status.sh
# Test the simplest test function
# By J. Stuart McMurray
# Created 20250803
# Last Modified 20250803

. ./t/t.subr
. ./shmore.subr

# This should fail, but gracefully.
set +e
tap_ok 'Should fail because we forgot a status' 'ok_without_status_filename' 14
tap_ok 'not a number' \
        "Should fail because our status isn't numeric" \
        'ok_without_status_filename' 15
set -e

subtest() {
        set +e
        tap_ok 'not a number' \
                "Non-numeric status in a subtest" \
                'ok_without_status_filename' 21
        set -e
        tap_pass "A pass"
}
tap_subtest "A Subtest" "subtest" 'ok_without_status_filename' 26

# This should work.
tap_ok 0 'Should succeed because we remembered a status'
