#!/usr/bin/env perl
#
# shelltest.pm
# Run a subtests passing shell names
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250225

package ShellTest;

use Carp;
use Exporter 'import';
use IPC::Cmd qw/can_run/;
use Test::More;

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

# Export our function.  No point importing this module and not getting it.
our @EXPORT = qw/slurp test_glob/;

# Shells under which to test the scripts.
our @shells = ("ash", "bash", "dash", "ksh", "ksh93", "mksh", "posh", "sh", "yash", "zsh");

# have_shell returns true if we can execute $shell (which may be any program).
sub have_shell($shell) { defined can_run($shell); }

# test_glob runs $testsub in a subtest with two arguments, a shell name and
# a filename.  $testsub should be something like sub ($shell, $filename) {}
# and should expect to be run alone in its own subtest; it should deal with
# plan things.
# Shells which are not available will not be passed to $testsub but will cause
# skipped subtests.
# tap_plan will # be called with the number of tests emitted by test_glob plus
# $addl_plan.
sub test_glob($pattern, $testsub, $addl_plan = 0) {
        # Work out the files to test and emit a plan.
        my @filenames = glob($pattern);
        plan tests => $addl_plan + @filenames;

        # Test each file in as many shells as we can.
        for my $filename (@filenames) {
                # One subtest per file
                subtest $filename => sub {
                        plan tests => 0+@shells;
                        for my $shell (@shells) {
                                # One sub-subtest per shell
                                subtest $shell => sub {
                                        unless (have_shell $shell) {
                                                plan skip_all =>
                                                        "Not installed";
                                                return;
                                        }
                                        # Whew, made it.
                                        &$testsub($shell, $filename);
                                };
                        }
                };
        }
}

# I think we've all defined this many times.
sub slurp($file) {
        open my $F, "<", "$file" or croak "open $file: $!";
        local $/;
        return <$F>;
}

1;
