#!/bin/sh
#
# echo.sh
# Test tap_note and tap_diag
# By J. Stuart McMurray
# Created 20250201
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_plan 1

# Make sure we don't expand wildcards.
tap_diag "Before diag star-slash"
tap_diag "*/"
tap_note "Before note star-slash"
tap_note "*/"

# Make sure we add #'s on lines and can also handle multiple arguments.
tap_diag Diag "with multiple" arguments
tap_note Note "with multiple" arguments
tap_diag "Diag with
multiple lines" and multiple arguments
tap_note "Note with
multiple lines" and multiple arguments

tap_ok 0
