#!/usr/bin/env perl
#
# subtest_ok.pl
# Test a very simple subtest
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

use warnings;
use strict;

use Test::More;

ok 1;
ok 1, "Simple ok";

subtest "Simple subtest" => sub {
        ok 1;
        ok 1, "Simple subtest test";
        subtest "Simple subsubtest" => sub {
                plan tests => 2;
                ok 1;
                ok 1, "Simple subsubtest test";
        };
};

ok 1, "After subtest";

done_testing;
