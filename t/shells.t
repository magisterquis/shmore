#!/usr/bin/env perl
#
# shells.t
# Warn someone if we're missing a shell against which to test
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250218

use warnings;
use strict;

use ShellTest;
use Test::More;

plan tests => 0+@ShellTest::shells;

# Warn if we're missing a shell
for my $shell (@ShellTest::shells) {
        SKIP: {
                unless (ShellTest::have_shell($shell)) {
                        skip "Don't have $shell", 1 
                }
                pass "Have $shell";
        }
}

done_testing;
