#!/usr/bin/env perl
#
# util.t
# Make sure things from util.subr work
# By J. Stuart McMurray
# Created 20260317
# Last Modified 20260317

use ShellTest qw/slurp test_glob/;
use Test::More;

use strict;
use warnings;
no warnings 'experimental::signatures';
use feature qw/signatures/;

test_glob("t/testdata/util/*.sh", sub($shell, $shf) {
        plan tests => 2;
        my $wantf = "$shf.want";
        defined(my $want = slurp "$wantf") or
                die "Could not slurp $wantf: $!";
        my $got = `$shell $shf 2>&1`;
        is $?,   0,     "Scrpt ran happily";
        is $got, $want, "Output correct";
});

done_testing;
