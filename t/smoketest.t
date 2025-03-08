#!/bin/sh
#
# smoketest.t
# Make sure we can just load shmore
# By J. Stuart McMurray
# Created 20250308
# Last Modified 20250308

. ./t/t.subr    # Set -euo pipefail, or close.
. ./shmore.subr # Load shmore.

tap_pass "Loaded ok"
