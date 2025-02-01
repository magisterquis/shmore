#!/usr/bin/env perl
#
# echo.pl
# Test diag and note
# Test the simplest test function
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20250201

use warnings;
use strict;

use Test::More;

ok 1;
diag "Diag";
note "Note";
subtest "Subtest" => sub {
        ok 1;
        diag "Subtest Diag";
        note "Subtest Note";
        subtest "Subsubtest" => sub {
                ok 1;
                diag "Subsub Diag Line 1/2\nSubsub Diag Line 2/2";
                note "Subsub Note Line 1/2\nSubsub Note Line 2/2";
                diag "Subsubtest Diag";
                note "Subsubtest Note";
        };
};

diag "Diag before empty";
diag;
diag "Diag after empty";

note "Note before empty";
note;
note "Note after empty";

# Make sure we don't expand wildcards.
diag "Diag before star-slash";
diag "*/";
note "Note before star-slash";
note "*/";

done_testing;
