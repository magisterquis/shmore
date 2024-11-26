#!/usr/bin/env perl
#
# not_ok_no_msg.pl
# Not ok messages which don't have info
# By J. Stuart McMurray
# Created 20241114
# Last Modified 20241114

use warnings;
use strict;

use Test::More;


TODO: {
        local $TODO = "A Dummy TODO Skip Reason";
        todo_skip "A TODO Skip Reason", 2;
}

subtest "A TODO Skip Subtest" => sub {
        TODO: {
                local $TODO = "A Dummy TODO Skip Subtest Reason";
                todo_skip "A TODO Skip Subtest Reason", 2;
        }
};

done_testing;
