#!/usr/bin/env perl
#
# sameoutput.t
# Ensure shmore and Test::More produce the same output
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250218

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

# check_ret checks the return code for errors.  It prints a diagnostic message
# if it sees something odd.
# $what describes what died.  It should be capitalized.
sub check_ret ($what, $rc) {
        if ($? == -1) {
                diag "Return: $?";
        } elsif ($? & 127) {
                diag "%s died with signal %d, %s coredump\n",
                        $what, ($? & 127),  ($? & 128) ? 'with' : 'without';
        }
}

# remove_line_references removes filenames and line numbers.
sub remove_line_references(@ls) {
        @ls = map { s/(at .*? line) (\d+|\?\?\?)\.$/$1 __line__./rs } @ls;
        @ls = map { s/(at).*?(line __line__\.)$/$1 __file__ $2/rs   } @ls;
        return join "", @ls;
}

# test_output checks if the output streams from the .sh file and its .pl
# counterpart are the same.  The third argument is appended to commands to
# run to select which output stream to read.
sub test_output($shell, $shf, $redir) {
        plan tests => 2;

        # Corresponding perl script
        my $plf = $shf =~ s/\.sh$/.pl/r;

        # Get output from both versions.
        $? = 0;
        my $sgot = remove_line_references(`$shell $shf $redir`);
        my $sret = $? >> 8;
        check_ret("Shell $shell", $sret);
        $? = 0;
        my $pgot = remove_line_references(`perl $plf $redir`);
        my $pret = $? >> 8;
        check_ret("Perl", $pret);

        # Make sure everything's the same.
        is $sgot, $pgot, "Output";
        is $sret, $pret, "Exit code";
}

test_glob("t/testdata/same_output/*.sh", sub($shell, $shf) {
        plan tests => 2;
        subtest "stdout", \&test_output, $shell, $shf, "2>/dev/null";
        subtest "stderr", \&test_output, $shell, $shf, "2>&1 1>/dev/null";
});

done_testing;
