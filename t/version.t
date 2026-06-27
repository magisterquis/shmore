#!/usr/bin/env perl
#
# version.t
# Make sure SHMORE_VERSION matches the git tag
# By J. Stuart McMurray
# Created 20260401
# Last Modified 20260627

use autodie;
use strict;
use warnings;

use feature 'signatures';

use IPC::Cmd qw/can_run/;
use Test::More;

# Only works if we have git(1).
unless (can_run "git") {
        plan skip_all => "git(1) not found";
}
plan tests => 3;

# run runs an external command, returning the output less trailing newlines.
sub run ($cmd) { `$cmd` =~ s/\n+$//r }

# Current git version is either the current tag or branch name.
my $git_version;
if ("" eq ($git_version = run "git tag --points-at")) {
        $git_version = run "git branch --show-current";
}

# Master branch should always have a tag.
isnt $git_version, "master", "Not on a master branch without a tag";

# Work out our current version, as far as shmore.subr knows.
chomp(my $subr_version = `ksh -c '. ./shmore.subr; echo "\$SHMORE_VERSION"'`);
isnt $subr_version, "", "Got a version from shmore.subr";

# Make sure shmore.subr has the correct version.
is $subr_version, $git_version, "Version in shmore.subr correct";

done_testing;
