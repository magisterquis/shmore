#!/bin/sh
#
# like_leading_hyphen.sh
# Handle like arguments with leading hyphens
# By J. Stuart McMurray
# Created 20250729
# Last Modified 20250729

. ./t/t.subr
. ./shmore.subr

tap_plan 1

HAVE='-E > 7f3f06f42000-7f3f06f43000 r--p 00000000 00:00 0'
RE='^-E > [0-9a-f]+-[0-9a-f]+ [r-][w-][x-]p 0{8} 00:00 0$'
tap_like "$HAVE" "$RE" "Match";
