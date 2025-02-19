#!/usr/bin/env perl
#
# nested_subtests.t
# Test nested subtests
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

use ShellTest;
use Test::More;

use warnings;
use strict;

use feature 'signatures';
no warnings 'experimental::signatures';

# We run this as its own test so as to ignore line numbers, which different
# shells report differently when $LINENO is used inside a function.

test_glob("t/testdata/nested_subtests/*.sh", sub ($shell, $filename) {
        # Grab the TAP output and strip line numbers.
        my $o = `$shell $filename 2>&1` =~ s/(at ).*? line (\d|\?\?\?)+/$1/grs;
        is $o, slurp($filename . ".want"), "Correct output";
});

done_testing;

