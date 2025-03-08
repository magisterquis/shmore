#!/bin/sh
#
# ok.sh
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_plan 12

tap_ok 0
tap_ok 0 "Simple ok"
tap_ok 1
tap_ok 1 "Simple fail"
tap_ok 1 "Simple fail with file" "$0"
tap_ok 1 "Simple fail with file and line" "$0" "${LINENO:-""}"
tap_pass "Simple pass"
tap_pass "Simple pass with file" "$0"
tap_pass "Simple pass with file and line" "$0" "${LINENO:-""}"
tap_fail "Simple fail"
tap_fail "Simple fail with file" "$0"
tap_fail "Simple fail with file and line" "$0" "${LINENO:-""}"
