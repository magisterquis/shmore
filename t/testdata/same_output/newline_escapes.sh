#!/bin/sh
#
# newline_escapes.sh
# Test tap_is with a GOT that has \n's
# By J. Stuart McMurray
# Created 20250430
# Last Modified 20250430

. ./t/t.subr
. ./shmore.subr

tap_plan 1

GOT='104         printf("nind: %d\n", nind); /* DEBUG */
105         printf("entry: %p\n", (void *)e); /* DEBUG */'
WANT=''

tap_is "$GOT" "$WANT" "No files with DEBUG comments"
