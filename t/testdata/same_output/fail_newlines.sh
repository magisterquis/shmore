#!/bin/sh
#
# fail_newlines.sh
# Make sure newlines before fails works as expected
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

set -e

. ./shmore.subr

tap_pass "A first pass" "$0" $LINENO
tap_fail "A first fail" "$0" $LINENO
tap_pass "A second pass" "$0" $LINENO

# Make sure TODOs work after a fail
tap_fail "A pre-TODO fail" "$0" $LINENO
TAP_TODO="Testing newlines after a fail"
tap_fail "A post-fail first TODO fail" "$0" $LINENO
tap_fail "A post-fail second TODO fail" "$0" $LINENO
TAP_TODO=
tap_fail "A post-TODO fail" "$0" $LINENO
tap_pass "A third pass" "$0" $LINENO
tap_fail "A post-pass fail" "$0" $LINENO

# Make sure TODOs work after a pass
tap_pass "A pre-TODO pass" "$0" $LINENO
TAP_TODO="Testing newlines after a pass"
tap_fail "A post-pass first TODO fail" "$0" $LINENO
tap_fail "A post-pass second TODO fail" "$0" $LINENO
TAP_TODO=
tap_pass "A post-TODO pass" "$0" $LINENO
tap_fail "A post-TODO-pass fail" "$0" $LINENO

# Make sure three fails in a row work.
tap_pass "A pre-three-fail pass" "$0" $LINENO
tap_fail "A first three-fail fail" "$0" $LINENO
tap_fail "A second three-fail fail" "$0" $LINENO
tap_fail "A third three-fail fail" "$0" $LINENO

subtest() {
        tap_fail "A first subtest fail" "$0" $LINENO
        tap_fail "A second subtest fail" "$0" $LINENO
}
tap_subtest "A failed subtest" subtest "$0" $LINENO
