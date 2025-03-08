#!/bin/ksh
#
m4_changecom()m4_dnl
# m4_name.t
# Script to run tests on m4_name
# By J. Stuart McMurray
# Created 20250228
# Last Modified 20250308

# Generated m4_esyscmd(date +%Y%m%d)m4_dnl

set -euo pipefail

NDONE=0 # Number of tests finished

# Test plan, which is the number of test scripts we have.
echo '1..m4_eval(m4_esyscmd(ls ../../t/*.t | wc -l))'

( cd m4_srcdir &&
        tar -cf - \
                -s '/.*\.sw.$//' \
                -s '/^\.\/\.git$//' \
                -s '/^\.\/\.git\/.*//' \
                -s '/^\.\/t\/digitalocean$//' \
                -s '/^\.\/t\/digitalocean\/.*//' \
                .
) | m4_patsubst(m4_include(m4_ssh), `
', `') '
        trap "rm -rf m4_remdir" EXIT
        rm -rf m4_remdir &&
        mkdir m4_remdir &&
        (
                cd m4_remdir &&
                tar -xf - &&
                m4_testcmd ||:
        )
' 2>&1 |
tee m4_tout |
# Update every time a test finishes
while read TNAME REST; do
        # Don't bother if this isn't a test result.
        if [[ "$TNAME" != t/*.t || $REST == \(Wstat* ]]; then
                continue
        fi

        # Update with this status.
        : $((NDONE++))
        if [[ "$REST" == *\ ok ]]; then
                echo "ok $NDONE - $TNAME"
        else
                echo "not ok $NDONE - $TNAME"
        fi
done

# vim: ft=sh
