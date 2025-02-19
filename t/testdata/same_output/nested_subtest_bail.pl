#!/usr/bin/env perl
#
# nested_subtest_bail.pl
# Test bailing from a deep subtest
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use Test::More;

pass;
fail;
subtest "L1 Subtest" => sub {
        pass;
        fail;
        subtest "L2 Subtest" => sub {
                pass;
                fail;
                subtest "L3 Subtest" => sub {
                        pass;
                        fail;
                        BAIL_OUT "Deep nesting";
                        pass;
                        fail;
                };
                pass;
                fail;
        };
        pass;
        fail;
};
pass;
fail;
