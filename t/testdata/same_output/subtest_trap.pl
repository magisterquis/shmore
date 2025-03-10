#!/usr/bin/env perl
#
# subtest_trap.pl
# Make sure a trap calling tap_done_testing in a subtest works
# By J. Stuart McMurray
# Created 20250310
# Last Modified 20250310

use warnings;
use strict;

use Test::More tests => 1;

subtest "A Subtest" => sub {
        plan tests => 2;
        pass "A Pass";
        fail "A Fail";
        done_testing;
};

done_testing;
