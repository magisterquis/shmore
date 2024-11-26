#!/bin/sh
#
# simple_fail.sh
# Test a really simple failed subtest
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

set -e

. ./shmore.subr

subtest() { 
        subtest() { tap_fail; }
        tap_subtest "Simple Subsubtest" subtest
}
tap_subtest "Simple Subtest" subtest
