#!/usr/bin/env perl
#
# line_numbers.t
# Make sure the README has the right line numbers
# By J. Stuart McMurray
# Created 20241126
# Last Modified 20250308

use warnings;
use strict;

use ShellTest;
use Test::More tests => 1;

# Read in the README
my $readme_name = "README.md";
my $readme = slurp($readme_name) or die "Cannot read $readme_name";
my @readme = split /\n/, $readme;

# Get variables/functions and line numbers from the README.
my %readme_lns;
for (@readme) {
        next unless
                /^\[`((?:tap|TAP)_[_[:alpha:]]+)`\]\((\.\/src\/[a-z]+\.subr#L\d+)\)/;
        my $fn = $1;
        my @fl = split /#L/, $2;
        $readme_lns{$fn} = {
                "f" => $fl[0],
                "l" => $fl[1],
        };
}

# Get variables/functions and line numbers from the source files.
my %file_lns;
while (my $f = <"./src/*.subr">) {
        open my $H, "<", $f or die "open $f: $!";
        while (<$H>) {
                next unless /^(tap_[_[:alpha:]]+)\(\)/ or
                        /^(TAP_[A-Z]+)=\$\{\g{1}:-""\}/;
                # Make sure we don't have dupes
                if (exists $file_lns{$1}) {
                        die "Duplicate function: $1";
                }
                # Note where this function is
                $file_lns{$1} = {
                        "f" => $f,
                        "l" => $.,
                };
        }
}

# Make sure line numbers line up.
is_deeply \%readme_lns, \%file_lns,
        "Function files and lines in the README are correct";
