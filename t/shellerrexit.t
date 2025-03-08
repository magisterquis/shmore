#!/usr/bin/env perl
#
# shellerrexit.t
# Make sure we exit unhappily if the shell would have without us.
# By J. Stuart McMurray
# Created 20250219
# Last Modified 20250308

use warnings;
use strict;

use ShellTest;
use Test::More;

use feature 'signatures';
no warnings "experimental::signatures";

# skip_output may be returned by a shell to skip tests against certain buggy
# shells.  Looking at you ancient Bash on macOS
my $skip_output = "SKIPSKIP\n";

# Esch test case consists of a broken script with shmore things and the script
# without.  They should return the same values.
test_glob("t/testdata/shellerrexit/*.with.sh", sub ($shell, $filename) {
        plan tests => 2;

        # File without shmore things.
        my $with    = $filename;
        my $without = $filename =~ s/\.with\.sh$/.without.sh/r;
        ok -f $without, "Have $without";

        # Run the scripts to get the return status.
        SKIP: {
                my $with_output = `$shell $with 2>&1`;
                my $with_ret = $? >> 8;
                skip "Buggy shell", 1 if $skip_output eq $with_output;
                `$shell $without 2>&1`;
                my $without_ret = $? >> 8;

                # All we really care about is the two exit codes being the
                # same.
                is $with_ret, $without_ret,
                        "Exit status same as without shmore ($without_ret)";
                };
});

done_testing;
