#!/bin/sh
#
# like.sh
# Test like and unlike
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

set -e

. ./shmore.subr

tap_like "abc" "ab?c" "Like Match"
tap_like "def" "ab?c" "Like Not Match"
tap_like "abc" "a)bc" "Like Bad Regex"
tap_unlike "abc" "ab?c" "Unlike Fail"
tap_unlike "def" "ab?c" "Unlike Succeed"
