#!/usr/bin/env perl
#
# bail.pl
# Test bailing out
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

use warnings;
use strict;

use Test::More;

pass;
subtest "Bailing Subtest" => sub {
        BAIL_OUT "Test test test";
};
pass;
done_testing;
