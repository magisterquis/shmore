#!/usr/bin/env perl
#
#.debug.t
# Make sure we don't have any DEBUGs 
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250222

use warnings;
use strict;

use File::Find;
use Test::More;

# tocheck is our list of files to check.
my @tocheck;

# gather_sources puts the file found by find in tocheck if it's worth checking.
# It skips anything in .git, irregular files, and vim swapfiles.
sub gather_sources {
        # Don't bother with the .git directory
        return if $File::Find::dir =~ m,\./\.git,;
        # Don't bother if this isn't a file
        return unless -f;
        # Don't bother with vim swapfiles.
        return if $File::Find::name =~ /\.sw.$/;
        # Looks worth checking.
        push @tocheck, $File::Find::name;
}
find({wanted => \&gather_sources, no_chdir => 1}, ".");

# Check ALL the files!
plan tests => 0+@tocheck;
for my $fn (@tocheck) {
        # Slurp and check for #\s+DEBUGs
        open my $F, "<", $fn or die "Could not open $fn: $!";
        my @ls; # Lines with The Thing
        while (<$F>) {
                if (/#\s+DEBUG/i) {
                        push @ls, $.;
                }
        }
        is join(" ", @ls), "", "$fn has no lines with DEBUG";
}

done_testing;
