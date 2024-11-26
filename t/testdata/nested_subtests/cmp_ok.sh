#!/bin/sh
#
# cmp_ok.sh
# Test nested cmp_ok
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_pass
tap_cmp_ok "abc" "=" "def" "Unequal strings" "$0" "$LINENO"
tap_cmp_ok 1 "-gt" 2 "Unordered numbers" "$0" "$LINENO"
tap_cmp_ok 1 "-le" 1 "Ordered numbers" "$0" "$LINENO"
tap_cmp_ok 1 "-ne" 1 "Equal numbers"

subtest() {
        tap_pass
        tap_cmp_ok "abc" "=" "def" "Subtest Unequal strings" "$0" "$LINENO"
        tap_cmp_ok 1 "-gt" 2 "Subtest Unordered numbers" "$0" "$LINENO"
        tap_cmp_ok 1 "-le" 1 "Subtest Ordered numbers" "$0" "$LINENO"
        tap_cmp_ok 1 "-ne" 1 "Subtest Equal numbers"

        subtest() {
                tap_pass
                tap_cmp_ok "abc" "=" "def" "Subsubtest Unequal strings" "$0" "$LINENO"
                tap_cmp_ok 1 "-gt" 2 "Subsubtest Unordered numbers" "$0" "$LINENO"
                tap_cmp_ok 1 "-le" 1 "Subsubtest Ordered numbers" "$0" "$LINENO"
                tap_cmp_ok 1 "-ne" 1 "Subsubtest Equal numbers"
        }
        tap_subtest "Test Subsubtest" subtest "$0" "$LINENO"
}
tap_subtest "Test Subtest" subtest "$0" "$LINENO"
