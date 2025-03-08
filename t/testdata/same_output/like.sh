#!/bin/sh
#
# like.sh
# Test like and unlike
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20250308

. ./t/t.subr

. ./shmore.subr

tap_like "abc" 'ab?c' "Match"
tap_unlike "def" 'ab?c' "Unmatch"
