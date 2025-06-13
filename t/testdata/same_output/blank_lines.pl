#!/usr/bin/env perl
#
# blank_lines.pl
# Test tap_is with strings with blank lines
# By J. Stuart McMurray
# Created 20250613
# Last Modified 20250613

use warnings;
use strict;

use Test::More tests => 1;

my $got='foo

bar

tridge';

my $want='kittens

moose


zoomies';

is $got, $want, "Strings with blank lines";

done_testing;
