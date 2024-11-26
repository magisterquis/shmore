#!/bin/sh
#
# stdio.sh
# Make sure diag and note go to the right places.
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_ok 0;

subtest() {
        tap_ok 0;
        tap_diag "Subtest Diag"
        tap_note "Subtest Note"
        subtest() {
                tap_ok 0;
                tap_diag "Subsubtest Diag"
                tap_note "Subsubtest Note"
        }
        tap_subtest "Test Subsubtest" subtest "$0" "$LINENO"
}
tap_subtest "Test Subtest" "subtest" "$0" "$LINENO"
