#!/usr/bin/env perl
#
# expected_output.t
# Ensure we get expected bytes to stdout and stderr.
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

use ShellTest;
use Test::More;

use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';

run_test_with_glob("t/testdata/expected_stdio/*.sh", sub ($shell, $filename) {
        is `$shell $filename 2>/dev/null`,
                slurp($filename . ".out") ,
                "$filename - stdout";
        is `$shell $filename 2>&1 >/dev/null`,
                slurp($filename . ".err") ,
                "$filename - stderr";
});

done_testing;
