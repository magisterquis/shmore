#!/bin/sh
#
# stdio.sh
# Make sure cmp_ok goes to the right places.
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_cmp_ok "1" "-eq" "1" "Pass - -eq"
tap_cmp_ok "1" "-eq" "2" "Fail - -eq"

tap_cmp_ok "1" "-ne" "2" "Pass - -ne"
tap_cmp_ok "1" "-ne" "1" "Fail - -ne"

tap_cmp_ok "1" "-lt" "2" "Pass - -lt"
tap_cmp_ok "1" "-lt" "1" "Fail - -lt"
