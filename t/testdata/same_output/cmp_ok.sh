#!/bin/sh
#
# cmp_ok.sh
# Test cmp_ok, is, and isn't
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_pass
tap_is "abc" "abc" "Equal strings - is"
tap_isnt "abc" "def" "Unequal strings - isnt"
tap_cmp_ok "abc" "=" "abc" "Equal strings - cmp_ok"
tap_cmp_ok 123 "-lt" 234 "Unequal numbers"
tap_cmp_ok 123 "-eq" 123 "Equal numbers"
