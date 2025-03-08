#!/bin/sh
#
# empty_subtest.pl
# Make sure empty subtests are reported as such
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_plan 3

tap_pass "A passing test";

subtest() { :; }
tap_subtest "An empty subtest" subtest "$0" "${LINENO:-""}"

tap_pass "Another passing test";
