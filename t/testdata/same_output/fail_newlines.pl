#!/usr/bin/env perl
#
# fail_newlines.pl
# Make sure a two fails plus a few oks work
# By J. Stuart McMurray
# Created 20250218
# Last Modified 20250430

use warnings;
use strict;

use Test::More;


pass "A first pass";
fail "A first fail";
pass "A second pass";

# Make sure TODOs work after a fail
fail "A pre-TODO fail";
TODO: {
        local $TODO = "Testing newlines after a fail";
        fail "A post-fail first TODO fail";
        fail "A post-fail second TODO fail";
}
fail "A post-TODO fail";
pass "A third pass";
fail "A post-pass fail";

# Make sure TODOs work after a pass
pass "A pre-TODO pass";
TODO: {
        local $TODO = "Testing newlines after a pass";
        fail "A post-pass first TODO fail";
        fail "A post-pass second TODO fail";
}
pass "A post-TODO pass";
fail "A post-TODO-pass fail";

# Make sure three fails in a row work.
pass "A pre-three-fail pass";
fail "A first three-fail fail";
fail "A second three-fail fail";
fail "A third three-fail fail";

subtest "A failed subtest" => sub {
        fail "A first subtest fail";
        fail "A second subtest fail";
};

done_testing;

