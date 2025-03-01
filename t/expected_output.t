#!/usr/bin/env perl
#
# expected_output.t
# Ensure we get expected output
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250301

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature qw/signatures state/;
no warnings 'experimental::signatures';

# has_lineno returns true if the shell implements $LINENO.  The result is
# cached; it is relatively cheap to call multiple times.
sub has_lineno($shell) {
        # If we've already checked, return the previous answer.
        state %ln_shells;
        if (exists $ln_shells{$shell}) {
                return $ln_shells{$shell};
        }
        # See if the shell's got $LINENO and save the answer for next time.
        my $ret = `$shell -c 'echo \$LINENO'` =~ /\d+\n?/s;
        $ln_shells{$shell} = $ret;
        return $ret;
}

test_glob("t/testdata/expected_output/*.sh", sub ($shell, $filename) {
        SKIP: {
                # We skip shells which don't have $LINENO to leave good tests
                # available for shells which do.
                skip "$shell doesn't have \$LINENO" unless has_lineno($shell);
                # Simple got/want.
                is `$shell $filename 2>&1`,
                        slurp($filename . ".want") ,
                        "Correct output";
        };
});

done_testing;
