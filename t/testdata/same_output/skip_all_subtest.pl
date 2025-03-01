#!/usr/bin/env perl
#
# skip_all_subtest.pl
# Test subtest skip_all
# By J. Stuart McMurray
# Created 20240301
# Last Modified 20250301

use warnings;
use strict;


use Test::More tests => 8;

pass "Pre-subtest pass 1";
pass "Pre-subtest pass 2";
pass "Pre-subtest pass 3";
pass "Pre-subtest pass 4";
pass "Pre-subtest pass 5";
pass "Pre-subtest pass 6";
  




subtest "A skippy subtest" => sub {
        plan skip_all => "A subtest skip_all test";
        pass "A never-reached subtest pass";
};

pass "A post-subtest pass";

done_testing
