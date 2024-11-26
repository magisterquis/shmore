#!/usr/bin/env perl
#
# skip.pl
# Test skipping things
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

use warnings;
use strict;

use Test::More;

ok 1, "Before skipping";
SKIP: {
        skip "Outside subtest", 2;
}

ok 1, "Before subtest";
subtest "Skippy subtest" => sub { SKIP: {
        skip "Inside subtest", 2;
} };

ok 1, "Before end";
done_testing;
