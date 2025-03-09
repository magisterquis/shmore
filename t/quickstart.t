#!/usr/bin/env perl
#
# quickstart.t
# Make sure the quickstarts in examples/ and README are the same
# By J. Stuart McMurray
# Created 20250309
# Last Modified 20250309

use warnings;
use strict;

use ShellTest;
use Test::More;

# Find the quickstart script in the README.
my $readme = slurp "README.md";
$readme =~ s/.*^Example\n-------\n[^`]+\n[^\n]+\n//ms;
$readme =~ s/^```\n.*//ms;

# Skip past the set -euo pipefail line, because we can't use it in the
# example :(
$readme =~ s/.*^set -euo pipefail[^\n]+\n+//ms;

# Get the quickstart example, and skip past the set line.
my $example = slurp "examples/quickstart.t";
$example =~ s/.*^set -eu[^\n]*\n+//ms;
# And remove the vim modeline
$example =~ s/\n*^# vim: ft=sh//ms;

# Make sure they're the same.
is $readme, $example, "Quickstart in the README is the same as the example";

done_testing;
