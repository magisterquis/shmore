#!/usr/bin/env perl
#
# expected_output.t
# Ensure we get expected output
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20241109

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

run_test_with_glob("t/testdata/expected_output/*.sh", sub ($shell, $filename) {
        is `$shell $filename 2>&1`, slurp($filename . ".want") , $filename;
});

done_testing;
