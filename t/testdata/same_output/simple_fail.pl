#!/usr/bin/env perl
#
# simple_fail.pl
# Test a really simple failed subtest
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use Test::More;

subtest "Simple Subtest" => sub { 
        subtest "Simple Subsubtest" => sub { fail; }
};

done_testing;
