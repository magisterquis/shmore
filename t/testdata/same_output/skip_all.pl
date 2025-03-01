#!/usr/bin/env perl
#
# skip_all.pl
# Test script skip_all
# By J. Stuart McMurray
# Created 20240301
# Last Modified 20250301

use warnings;
use strict;

use Test::More skip_all => "A script skip_all test";

pass "A never-reached pass";

done_testing
