#!/usr/bin/env perl
#
# ok.pl
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241109

use warnings;
use strict;

use Test::More tests => 3;

ok 1;
ok 1, "Simple ok";
pass "Simple pass";
