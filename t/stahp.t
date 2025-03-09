#!/usr/bin/env perl
#
# stahp.t
# Test stahp.subr
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

use ShellTest;
use Test::More;

my $nfuncs = 4;                  # Number of functions in Stahp.
my $readme = "stahp.md";         # README equivalent.
my $source = "./stahp.subr";     # Source file.
my $xample = "examples/stahp.t"; # Example test script.

# Simple got/want.
test_glob("t/testdata/stahp/*.sh", sub ($shell, $filename) {
        is `$shell $filename 2>/dev/null`,
                slurp($filename . ".stdout") ,
                "Correct stdout";
        is `$shell $filename 2>&1 >/dev/null`,
                slurp($filename . ".stderr") ,
                "Correct stderr";
}, 6);

# Make sure line numbers are correct, as well.


# Grab functions and their lines from the source.
my %slns;                                  # Source line numbers.
my @ls = ("", split /\n/, slurp($source)); # Source lines.
while (my ($i, $l) = each @ls) {
        next unless $l =~ /^# (stahp_[a-z]+)\s+/;
        my $fn = $1; # Function name.
        # Make sure we've not seen this one yet.
        if (exists $slns{$fn}) {
                # This'll cause a bad plan error, but that's ok.
                fail "Duplicate definiton for $fn in $source ".
                        "on line $i (previous was $slns{$fn})";
        }
        # Note the line where we found it.
        $slns{$fn} = $i;
}

# Make sure we have the right number of functions.
is keys(%slns), $nfuncs, "Correct number of documented functions in $source";

# Grab functions and their lines from the readme.
my %rlns;                               # Readme line numbers.
@ls = ("", split /\n/, slurp($readme)); # Readme lines.
while (my ($i, $l) = each @ls) {
        while ($l =~ /\[`(stahp_[a-z]+)`\]\(${source}#L(\d+)\)/g) {
                my $fn = $1; # Function name.
                my $ln = $2; # Line number.
                # Make sure we've not seen this one yet.
                if (exists $rlns{$fn} and $ln != $rlns{$fn}) {
                        # This'll cause a bad plan error, but that's ok.
                        fail "A second line number found for $fn in $readme ".
                                "on line $i (found $ln, previous was $rlns{$fn})";
                }
                # Note the line where we found it.
                $rlns{$fn} = $ln;
        }
}

# Make sure we have the right number of functions.
is %rlns, $nfuncs, "Correct number of referred-to functions in $readme";

# Make sure the readme and source agree.
is_deeply \%rlns, \%slns,
        "Function files and lines in $readme match those in $source";

# Make sure we didn't use shmore functions in stahp_land.
for my $fn ($readme, $source, $xample) {
        my @ls = ("", split /\n/, slurp($fn)); # Readme lines.
        my @lns;
        while (my ($i, $l) = each @ls) {
                push @lns, $i if ($l =~ /[t]ap_/);
        }
        is join(" ", @lns), "", "$fn has no lines with shmore functions";
}

done_testing;
