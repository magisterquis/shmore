#!/usr/bin/env perl
#
# sameoutput.t
# Ensure shmore and Test::More produce the same output
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250301

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature qw/signatures state/;
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

# zsh_is_old indicates if zsh's version is before 5.6, when they fixed setting
# the exit status from the EXIT trap.
# zsh_is_old return false if $shell isn't zsh or if zsh's version is >=5.6.
# The first time zsh_is_old is called it will call zsh, but the answer will be
# cached; subsequent calls are cheap.
# https://gitlab.com/zsh-org/zsh/-/commit/d7110d8f01cae8c8d51c7abd0255f533cd8b8623
sub zsh_is_old($shell) {
        # Doesn't matter if it's not zsh.
        if ("zsh" ne $shell) {
                return 0;
        }
        # Answer-caching.
        state $zsh_is_old;
        # Work out the shell's version if we don't know
        # already.
        unless (defined $zsh_is_old) {
                my @ver = split /\./,
                        (`$shell -c 'echo \$ZSH_VERSION'` =~ s/\n//rs);
                # Make sure we have at least a major and minor.
                unless (2 <= 0+@ver) {
                        push @ver, 0;
                }
                $zsh_is_old = ($ver[0] > 5) || (5 == $ver[0] && 6 > $ver[1]);
        }
        return $zsh_is_old;
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
        SKIP: {
                skip "Old zsh EXIT trap can't set exit status", 1
                        if zsh_is_old $shell;
                is $sret, $pret, "Exit code";
        }
}

test_glob("t/testdata/same_output/*.sh", sub($shell, $shf) {
        plan tests => 2;
        subtest "stdout", \&test_output, $shell, $shf, "2>/dev/null";
        subtest "stderr", \&test_output, $shell, $shf, "2>&1 1>/dev/null";
});

done_testing;
