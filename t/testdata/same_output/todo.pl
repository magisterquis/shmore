#!/usr/bin/env perl
#
# todo.pl
# Test TAP_TODO
# By J. Stuart McMurray
# Created 20241112
# Last Modified 20241112

use warnings;
use strict;

use Test::More;

pass "Before TODO block";
TODO: {
        local $TODO = "A TODO Message";
        pass "A pass";
        subtest "A Subtest" => sub {
                pass "A pass";
        };
}
pass "After TODO block";

done_testing;
