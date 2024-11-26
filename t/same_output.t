#!/usr/bin/env perl
#
# sameoutput.t
# Ensure shmore and Test::More produce the same output
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241109

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

# check_ret checks the return code for errors.  It prints a diagnostic message
# if it sees something odd.
sub check_ret ($rc) {
        if ($? == -1) {
                diag "Return: $?";
        }
        elsif ($? & 127) {
                diag "Died with signal %d, %s coredump\n",
                        ($? & 127),  ($? & 128) ? 'with' : 'without';
        }
}

run_test_with_glob("t/testdata/same_output/*.sh", sub ($shell, $shf) {
        subtest $shf => sub {
                # Corresponding perl script
                my $plf = $shf =~ s/\.sh$/.pl/r;
                # Make sure the output is the same.
                my $sgot = `$shell $shf 2>&1`;
                my $sret = $?;
                check_ret($sret);
                my $pgot = `perl $plf 2>&1`;
                my $pret = $?;
                check_ret($pret);
                is $sgot, $pgot, "Output";
                is $sret, $pret, "Exit code";
        }
});


done_testing;
