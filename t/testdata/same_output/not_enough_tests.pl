#!/usr/bin/env perl
#
# not_enough_tests.pl
# Test what happens if we forget a test
# By J. Stuart McMurray
# Created 20250222
# Last Modified 20250222

use warnings;
use strict;

use Test::More tests => 6;


subtest "A lacking subtest" => sub {
        plan tests => 4;
        pass "A passing subtest test";
        fail "A failing subtest test";

};

pass "A passing test";
fail "A failing test";

done_testing;
