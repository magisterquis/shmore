#!/bin/sh
#
# cmp_ok.sh
# Test tap_cmp_ok
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_cmp_ok "a" "=" "a" "Pass - ="
tap_cmp_ok "a" "=" "b" "Fail - ="

tap_cmp_ok "a" "!=" "b" "Pass - !="
tap_cmp_ok "a" "!=" "a" "Fail - !="

tap_cmp_ok "1" "-eq" "1" "Pass - -eq"
tap_cmp_ok "1" "-eq" "2" "Fail - -eq"

tap_cmp_ok "1" "-ne" "2" "Pass - -ne"
tap_cmp_ok "1" "-ne" "1" "Fail - -ne"

tap_cmp_ok "1" "-lt" "2" "Pass - -lt"
tap_cmp_ok "1" "-lt" "1" "Fail - -lt"
