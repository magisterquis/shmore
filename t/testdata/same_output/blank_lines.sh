#!/bin/sh
#
# blank_lines.sh
# Test tap_is with strings with blank lines
# By J. Stuart McMurray
# Created 20250613
# Last Modified 20250613

. ./t/t.subr
. ./shmore.subr

tap_plan 1

GOT='foo

bar

tridge'

WANT='kittens

moose


zoomies'

tap_is "$GOT" "$WANT" "Strings with blank lines"
