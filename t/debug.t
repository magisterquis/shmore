#!/usr/bin/env perl
#
#.debug.t
# Make sure we don't have any DEBUGs 
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use File::Find;
use Test::More;

# check checks each regular file found by find for the presence of #\s+DEBUG,
# with or without a space.
sub check {
        # Don't bother with the .git directory
        return if $File::Find::dir =~ m,\./\.git,;
        # Don't bother if this isn't a file
        return unless -f;

        # Slurp and check for #\s+DEBUGs
        open my $F, "<", $File::Find::name or die "Could not open $_: $!";
        my @ls; # Lines with The Thing
        while (my $l = <$F>) {
                if ($l =~ /#\s+DEBUG/i) {
                        push @ls, $.;
                }
        }
        is join(" ", @ls), "", "$File::Find::name has no lines with DEBUG";
}
find({wanted => \&check, no_chdir => 1}, ".");

done_testing;
