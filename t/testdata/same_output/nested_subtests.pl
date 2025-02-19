#!/usr/bin/env perl
#
# nested_subtests.pl
# Test subtests
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use Test::More;

ok 1, "Test Pass";
ok 0, "Test Fail";

subtest "Test Subtest" => sub {
        ok 1, "Subtest Ok Pass";
        ok 0, "Subtest Ok Fail";
        subtest "Test Subsubtest" => sub {
                ok 1, "Subsubtest Ok Pass";
                ok 0, "Subsubtest Ok Fail";
                ok 0, "SubSubtest Ok Fail quietly";
                ok 0;
                is "foo", "bar", "Subsubtest is";
                isnt "foo", "foo", "Subsubtest isnt";
        };
};

ok 1, "After Pass";
ok 0, "After Fail";

done_testing;
