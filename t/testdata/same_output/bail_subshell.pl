#!/usr/bin/env perl
#
# bail_subshell.pl
# Test bailing out from a test in a subshell
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20250201

use warnings;
use strict;

use Test::More;

pass;
subtest "Bailing Subtest" => sub {
        BAIL_OUT "Test test test";
};
pass;
done_testing;
