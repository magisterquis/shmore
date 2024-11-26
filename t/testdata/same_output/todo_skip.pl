#!/usr/bin/env perl
#
# todo_skip.pl
# test tap_todo_skip
# By J. Stuart McMurray
# Created 20241114
# Last Modified 20241114

use warnings;
use strict;

use Test::More;

pass "Before TODO block";
TODO: {
        local $TODO = "A Dummy TODO Message";
        subtest "A Subtest" => sub {
                TODO: {
                        todo_skip "A Reason", 2;
                }
        };
}
pass "After TODO block";

pass "A Pass";

done_testing;
