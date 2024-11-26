#!/usr/bin/env perl
#
# shelltest.pm
# Run a subtests passing shell names
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241109

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
our @EXPORT = qw/run_test_with_glob  slurp/;

# Shells under which to test the scripts.
my @shells = ("ash", "bash", "dash", "ksh", "sh", "zsh");

# run_with_shells runs $testsub in a subtest with one argument, the shell name.
# Shells which are not available will not be passed to $testsub.  $testsub
# should be something like sub ($shell){...}.
sub run_with_shells($testsub)  {
        # Test in ALL the shells!
        for my $shell (@shells) {
                subtest $shell => sub {
                        # Don't bother if we don't have this shell installed.
                        unless (defined can_run($shell)) {
                                plan skip_all => "Not installed";
                                return;
                        }
                        &$testsub($shell);
                };
        }
}

# run_test_with_glob is like run_with_shells, but additionally calls testsub
# for each filename which matches $pattern.  $testsub should be something like
# sub ($shell, $filename)... 
sub run_test_with_glob($pattern, $testsub) {
        run_with_shells(sub ($shell) {
                my @filenames = glob($pattern);
                for my $filename (glob($pattern)) {
                        &$testsub($shell, $filename);
                }
        })
}

# I think we've all defined this many times.
sub slurp($file) {
        open my $F, "<", "$file" or croak "open $file: $!";
        local $/;
        return <$F>;
}

1;
