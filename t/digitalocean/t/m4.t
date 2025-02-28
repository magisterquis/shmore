#!/usr/bin/env perl
#
# m4.t
# Make sure no m4_ macros were forgotten in t/*.t
# By J. Stuart McMurray
# Created 20250228
# Last Modified 20250228

use warnings;
use strict;

use Test::More;

# We check the test files, excluding this one.
my @tocheck = grep { $0 ne $_ } glob("t/*.t");
plan tests => 0+@tocheck;

# Check ALL the files.
for my $fn (@tocheck) {
        # Slurp and check for m4_
        open my $F, "<", $fn or die "Could not open $fn: $!";
        my @ls; # Lines with m4_ macros.
        while (<$F>) {
                if (/m4_/) {
                        push @ls, $.;
                }
        }
        # Should have got emptiness.
        is join(" ", @ls), "", "$fn has no lines with m4_";
}

done_testing;
