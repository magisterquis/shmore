#!/usr/bin/env perl
#
# newline_escapes.pl
# Test tap_is with a GOT that has \n's
# By J. Stuart McMurray
# Created 20250430
# Last Modified 20250430

use warnings;
use strict;

use Test::More tests => 1;

my $got = '104         printf("nind: %d\n", nind); /* DEBUG */
105         printf("entry: %p\n", (void *)e); /* DEBUG */';
my $want = '';

is $got, $want, "No files with DEBUG comments";

done_testing;
