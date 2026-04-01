#!/usr/bin/env perl
#
# version.t
# Make sure SHMORE_VERSION matches the tag.
# By J. Stuart McMurray
# Created 20260401
# Last Modified 20260401

use autodie;
use strict;
use warnings;

use File::Basename;
use IPC::Cmd qw/can_run/;
use ShellTest qw/slurp/;
use Test::More tests => 8;

# $default_version is the version to use if we're not tagged at any particular
# version.
my $default_version = "devel";

# Get the current reference or commit ID.
chomp(my $head = slurp ".git/HEAD");

# Work out our current version, as far as shmore.subr knows.
chomp(my $subr_version = `ksh -c '. ./shmore.subr; echo "\$SHMORE_VERSION"'`);
isnt $subr_version, "", "Got a version from shmore.subr";

# Get our commit ID, which we'll then use to check for tags.
my $id = $head;
chomp($id = slurp ".git/$id") if $id =~ s/^ref: //;
like $id, qr/^[0-9a-f]{40}$/, "Commit ID looks like a commit ID";
# Work out which tags have this commit ID.
my @ps = grep {-f $_ and -1 != index slurp($_), $id} <".git/refs/tags/*">;
my @fs = map {basename $_} @ps;
cmp_ok 0+@fs, '<=', 1, "Commit does not have multiple tags";
# Work out what version we should have.
my $pp_ver = $fs[0] || $default_version;
# And make sure we have it.
is $subr_version, $pp_ver, "Version in shmore.subr correct - pure Perl";

# Check with git(1) as well, but only if we have it available.
SKIP: {
        skip "git(1) not found", 3 unless defined can_run("git");
        # Work out the current tag.
        my $tag = `git tag --points-at`;
        is $?, 0, "git(1) exited happily";
        # Work out what version we should have.
        chomp(my $git_ver = $tag || $default_version);
        # See if it matches SHMORE_VERSION.
        is $subr_version, $git_ver,
                "Version in shmore.subr correct - git(1)";
        # See if it matches the tag we got with pure perl.
        is $pp_ver, $git_ver, "Pure Perl and git(1) agree on expected version";
}

# We should have a tag if we're on the head of the master branch.
SKIP: {
        skip "Not on head of master branch", 1 unless
                "ref: refs/heads/master" eq $head;
        isnt $pp_ver, $default_version,
                "Should have tag on head of master branch";
}
