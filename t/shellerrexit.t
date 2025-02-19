#!/usr/bin/env perl
#
# shellerrexit.t
# Make sure we exit unhappily if the shell would have without us.
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20250219

use warnings;
use strict;

use ShellTest;
use Test::More;

use feature 'signatures';

# Esch test case consists of a broken script with shmore things and the script
# without.  They should return the same values.
test_glob("t/testdata/shellerrexit/*.with.sh", sub ($shell, $filename) {
        plan tests => 4;
        # File without shmore things.
        my $with    = $filename;
        my $without = $filename =~ s/\.with\.sh$/.without.sh/r;
        ok -f $without, "Have $without";

        # Get exit statuses for both.
        `$shell $with 2>&1`;
        my $with_ret = $? >> 8;
        `$shell $without 2>&1`;
        my $without_ret = $? >> 8;

        # Neither should have exited happily.
        isnt $with_ret,    0,    "$with exited unhappily";
        isnt $without_ret, 0, "$without exited unhappily";

        # But they should have the same exit status.  This assumes none of
        # the tests in *.with.sh fail.
        is $with_ret, $without_ret, "Exit status from shell";
});

done_testing;
