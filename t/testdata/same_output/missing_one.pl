#!/usr/bin/env perl
#
# missing_one.pl
# Make sure done_testing catches us if we only miss one test
# By J. Stuart McMurray
# Created 20250222
# Last Modified 20250222

use warnings;
use strict;

use Test::More tests => 4;


fail "A fail";
pass "A pass";
subtest "A subtest" => sub {
        plan tests => 6;
        pass "Pass one";
        pass "Pass two";
        pass "Pass three";
        pass "Pass four";
        pass "Pass five";

};

done_testing;
