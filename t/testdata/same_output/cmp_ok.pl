#!/usr/bin/env perl
#
# cmp_ok.pl
# Test cmp_ok, is, and isn't
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

use warnings;
use strict;

use Test::More;

pass;
is "abc", "abc", "Equal strings - is";
isnt "abc", "def", "Unequal strings - isnt";
cmp_ok "abc", "eq", "abc", "Equal strings - cmp_ok";
cmp_ok 123, "<", 234, "Unequal numbers";
cmp_ok 123, "==", 123, "Equal numbers";

done_testing;
