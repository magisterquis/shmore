#!/bin/sh
#
# unsetvar.with.sh
# Fail after not setting a variable, set -u
# By J. Stuart McMurray
# Created 20250308
# Last Modified 20250308

set -u

. ./shmore.subr

# Print something we've not set.
echo "$UNSETVAR"
