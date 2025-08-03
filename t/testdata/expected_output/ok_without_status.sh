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
tap_ok 'Should fail because we forgot a status' 'test_filename' 17
set -e

# This should work.
tap_ok 1 'Should succeed because we remembered a status' 'test_filename' 21
