#!/usr/bin/env perl
#
# like_leading_hyphen.pl
# Handle like arguments with leading hyphens
# By J. Stuart McMurray
# Created 20250729
# Last Modified 20250729

use warnings;
use strict;

use Test::More tests => 1;

my $have = '-E > 7f3f06f42000-7f3f06f43000 r--p 00000000 00:00 0';
my $re   = qr/^-E > [0-9a-f]+-[0-9a-f]+ [r-][w-][x-]p 0{8} 00:00 0$/;
like $have, $re, "Match";

done_testing;
