#!/usr/bin/env perl
#
# noexec.t
# Check shmore with shells' equivalent to ksh -n
# By J. Stuart McMurray
# Created 20260315
# Last Modified 20260317

use autodie;
use strict;
use warnings;

use ShellTest qw/have_shell @shells/;
use Test::More;

use feature 'signatures';
no warnings 'experimental::signatures';

# check_flags holds the flags each shell uses to check syntax.  In practice,
# all shells use -n, but this is here to prevent adding a shell which doesn't
# -n in the future but forgetting about this test.
my %check_flags = (
        "ash"   => "-n",
        "bash"  => "-n",
        "dash"  => "-n",
        "ksh"   => "-n",
        "ksh93" => "-n",
        "mksh"  => "-n",
        "posh"  => "-n",
        "sh"    => "-n",
        "yash"  => "-n",
        "zsh"   => "-n",
);

my @have_shells = grep {have_shell $_} @shells;

# One (sub)test per shell.
plan tests => 2*@have_shells;

# Check with each shell.
for my $shell (@have_shells) {
        # Make sure we have a flag for the shell.
        unless (defined $check_flags{$shell}) {
                fail "No syntax check flag for $shell";
                fail "No syntax check flag for $shell";
                continue
        }
        # Ask the shell if the syntax is ok.
        chomp(my $got = `$shell $check_flags{$shell} ./shmore.subr 2>&1`);
        # Make sure we didn't get any whining.
        is $got, "", "$shell - Syntax check clean";
        # Make sure it exited happily.
        is $?,    0, "$shell - Syntax check exited happily";
}

done_testing;
