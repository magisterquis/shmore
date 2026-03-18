#!/usr/bin/env perl
#
# shellcheck.t
# Run ShellCheck against shmore.subr
# By J. Stuart McMurray
# Created 20260318
# Last Modified 20260318

use autodie;
use strict;
use warnings;

use IPC::Cmd 'can_run';
use Test::More;

# Make sure we actually have ShellCheck.
my $shellcheck = can_run "shellcheck" or
        plan skip_all => "Shellcheck not available";

# Get the supported shell dialects.
chomp(my @dialects = map {split /, /, s/^.*\(|\)$//gr}
        grep /Specify dialect/, `$shellcheck -h 2>&1`);
plan tests => 0+@dialects;

# Run ShellCheck for each dialect.
SKIP: {
        for my $i (0..$#dialects) {
                        # Current dialect to try.
                my $dialect = $dialects[$i];
                # Did it work?
                my $got = `$shellcheck -s $dialect shmore.subr 2>&1`;
                unless (is $?, 0 ,"Shellcheck clean with dialect $dialect") {
                        diag $got;
                        skip "Previous ShellCheck failed", $#dialects-$i;
                }
        }
}

done_testing;
