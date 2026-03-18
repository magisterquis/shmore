#!/usr/bin/env perl
#
# retvals.t
# Make sure we don't have any unused TAP_RETURN_ values.
# By J. Stuart McMurray
# Created 20260318
# Last Modified 20260318

use autodie;
use strict;
use warnings;

use Test::More;

# Get shmore as lines.
my @shmore;
{
        my $fn = "shmore.subr";
        open my $F, "<", "$fn" or die "open $fn $!";
        @shmore = <$F>;
}

# Get the TAP_RETURN_ values.
chomp(my @tap_returns = grep {/^TAP_RETURN_[^=]+=\d+/} @shmore);
@tap_returns = map {s/=\d+$//r} @tap_returns;

# Two checks per TAP_RETURN value, one to check for double-defines, one to
# check it's actually used.
plan tests => 2*@tap_returns;

# Make sure each return value is defined only once but appears more than once.
for my $rv (@tap_returns) {
        # Make sure the value was only defined once.
        is 1, (grep {$rv eq $_} @tap_returns), "$rv defined only once";
        # Make sure the value was actually used.
        cmp_ok 0+(grep {-1 != index($_, $rv)} @shmore),
                '>', 1, "$rv defined and used";
}

done_testing;
