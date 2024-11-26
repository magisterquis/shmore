#!/bin/sh
#
# echo.sh
# Test diag and note
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_ok 0
tap_diag "Diag"
tap_note "Note"

subtest() {
        tap_ok 0
        tap_diag "Subtest Diag"
        tap_note "Subtest Note"

        subtest() {
                tap_ok 0
                tap_diag 'Subsub Diag Line 1/2
Subsub Diag Line 2/2';
                tap_note 'Subsub Note Line 1/2
Subsub Note Line 2/2';
                tap_diag "Subsubtest Diag"
                tap_note "Subsubtest Note"

        }
        tap_subtest "Subsubtest" subtest
}
tap_subtest "Subtest" subtest

tap_diag "Diag before empty"
tap_diag
tap_diag "Diag after empty"

tap_note "Note before empty"
tap_note
tap_note "Note after empty"