#!/usr/bin/env perl
#
# plan_and_done_testing.pl
# Make sure done_testing catches when we're going according to plan.
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241105

use warnings;
use strict;

use Test::More tests => 3;

ok 1;
ok 1;
ok 1;

done_testing;
