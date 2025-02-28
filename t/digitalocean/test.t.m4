#!/bin/ksh
#
m4_changecom()m4_dnl
# m4_name.t
# Script to run tests on m4_name
# By J. Stuart McMurray
# Created 20250228
# Last Modified 20250228

# Generated m4_esyscmd(date +%Y%m%d)m4_dnl

set -uo pipefail

echo '1..1'

if ( cd m4_srcdir &&
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
                m4_testcmd --jobs 9
        )
' >m4_tout 2>&1; then
        echo 'ok 1'
else
        echo 'not ok 1 - m4_name'
        if [ -n "${HARNESS_ACTIVE:-}" ] &&
                [ -z "${HARNESS_IS_VERBOSE:-}" ]; then
                echo >&2
                echo '#   Test on m4_name failed; see m4_tout' >&2
        fi
fi

# vim: ft=sh
