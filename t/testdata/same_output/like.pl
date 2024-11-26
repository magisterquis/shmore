#!/usr/bin/env perl
#
# like.pl
# Test like and unlike
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

use warnings;
use strict;

use Test::More;

like "abc", '/ab?c/', "Match";
unlike "def", '/ab?c/', "Unmatch";

done_testing;
