#!/usr/bin/env perl
#
# shells.t
# Warn someone if we're missing a shell against which to test
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20260316

use warnings;
use strict;

use ShellTest qw/have_shell @shells/;
use Test::More;

plan tests => 0+@shells;

# Warn if we're missing a shell
for my $shell (@shells) {
        SKIP: {
                unless (have_shell($shell)) {
                        skip "Don't have $shell", 1;
                }
                pass "Have $shell";
        }
}

done_testing;
