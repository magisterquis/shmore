#!/usr/bin/env perl
#
# empty_subtest.pl
# Make sure empty subtests are reported as such
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use Test::More tests => 3;

pass "A passing test";

subtest "An empty subtest" => sub {};

pass "Another passing test";
