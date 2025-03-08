#!/bin/sh
#
# pipefail.with.sh
# Fail after a pipeline fails with set -o pipefail
# By J. Stuart McMurray
# Created 20250308
# Last Modified 20250308

# Make sure we actually have pipefail
if ! ( set -o pipefail ) >/dev/null 2>&1; then
        exit 0
fi
set -o pipefail

. ./shmore.subr

# Something to trigger a fail.
r99() { return 99; }

# A failing pipeline.
echo "Here" | r99 | cat
