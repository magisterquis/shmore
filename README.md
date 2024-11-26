Shell [TAP](https://testanything.org) Producer 
==============================================
[TAP](https://testanything.org)-producing testing library.  More or less a
Shell knockoff of Perl's [Test::More](https://perldoc.perl.org/Test::More),
usable with [Prove](https://perldoc.perl.org/prove).

Just copy [`shmore.subr`](./shmore.subr) somewhere and source it.

Tested with `bash`, `dash`, `ksh`, `sh`, and `zsh` on OpenBSD and macOS.  It
should work elsewhere as well.

Examples are in [`./examples`](./examples), and have a look at [`wtrtdtmlb`'s
tests](https://github.com/magisterquis/wtrtdtmlb/tree/master/src/containers/jankins/t)
for IRL usage.

Example
-------
This test script
```sh
#!/bin/sh

# Source shmore.
. ./shmore.subr

# Note how many tests will be run.  Not strictly necessary but prevents missing
# or extra tests as well as makes prove a bit less boring to watch.
tap_plan 3

# Simplest test is to make sure a previous command worked.
/bin/echo "It worked" >/dev/null
tap_ok $? "Echo succeeded"

# More useful is comparing what we got and what we want.
GOT=$(echo "It worked")
WANT="It worked"
tap_is "$GOT" "$WANT" "Echo echoed properly"

# If we have perl, we can also test against a regex
if which perl >/dev/null 2>&1; then
        tap_like "$(date)" '20\d{2}$' "Still in the 21st century"
else
        # Or we can use tap_skip to note we skipped a test
        tap_skip "Missing perl" 1
fi
```
produces the following output
```
1..3
ok 1 - Echo succeeded
ok 2 - Echo echoed properly
ok 3 - Still in the 21st century
```
which looks like this IRL
```
$ prove examples/quickstart.t
examples/quickstart.t .. ok
All tests successful.
Files=1, Tests=3,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.01 csys =  0.03 CPU)
Result: PASS
```
or like this if we get verbose
```
$ prove -v examples/quickstart.t
examples/quickstart.t ..
1..3
ok 1 - Echo succeeded
ok 2 - Echo echoed properly
ok 3 - Still in the 21st century
ok
All tests successful.
Files=1, Tests=3,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.02 csys =  0.04 CPU)
Result: PASS
```

There are more examples in [`examples`](./examples).  To run them all at once,
try `prove -v examples/` in this directory.

API
---
Shmore's API consists of a handful of functions plus two variables.

### Functions
Optional arguments are in _italics_.
Each function links to better documentation.

Name                                      | Description                                                                    | `$1`              | `$2`                                                 | `$3`        | `$4`        | `$5`       | `$6`
------------------------------------------|--------------------------------------------------------------------------------|-------------------|------------------------------------------------------|-------------|-------------|------------|-----
[`tap_ok`](./src/ok.subr#L14)             | Notes whether a test succeded or failed; the most basic function               | `0` for succes    | _Test Name_                                          | _Test File_ | _Test Line_
[`tap_pass`](./src/ok.subr#L23)           | `tap_ok 0 "$@"`                                                                | _Test Name_       | _Test File_                                          | _Test Line_
[`tap_fail`](./src/ok.subr#L31)           | `tap_ok 1 "$@"`                                                                | _Test Name_       | _Test File_                                          | _Test Line_
[`tap_is`](./src/cmp.subr#L16)            | `[ "$1" == "$2" ]`                                                             | The Got           | The Expected                                         | _Test Name_ | _Test File_ | _Test Line_
[`tap_isnt`](./src/cmp.subr#L27)          | `[ "$1" != "$2" ]`                                                             | The Got           | The Not Expected                                     | _Test Name_ | _Test File_ | _Test Line_
[`tap_cmp_ok`](./src/cmp.subr#L40)        | `[ "$1" "$2" "$3" ]`                                                           | The Got           | A [`test(1)`](https://man.openbsd.org/test) operator | The Want    | _Test Name_ | _Test File_ | _Test Line_
[`tap_like`](./src/like.subr#L16)         | Uses Perl to test if a [regex](https://perldoc.perl.org/perlre) is matched     | The Got           | A Regex                                              | _Test Name_ | _Test File_ | _Test Line_
[`tap_unlike`](./src/like.subr#L20)       | Uses Perl to test if a [regex](https://perldoc.perl.org/perlre) is not matched | The Got           | A Regex                                              | _Test Name_ | _Test File_ | _Test Line_
[`tap_subtest`](./src/subtest.subr#L16)   | Run a [subtest](./examples/subtest.t)                                          | Subtest test name | Subtest function name                                | _Test File_ | _Test Line_
[`tap_skip`](./src/maybe.subr#L33)        | Equivalent to a number of `tap_ok 0`'s which note tests were skipped           | A Reason          | How many tests will be skipped
[`tap_todo_skip`](./src/maybe.subr#L42)   | Equivalent to a number of `tap_ok 1`s which also note the tests are TODO       | A Reason          | How many TODO tests will be skipped 
[`tap_diag`](./src/echo.subr#L14)         | Print a diagnostic message to stderr                                           | The Message; arguments will be joined with `"$*"`
[`tap_note`](./src/echo.subr#L18)         | Print a diagsontic message not seen when using a test harness                  | The Message; arguments will be joined with `"$*"`
[`tap_plan`](./src/plan.subr#L108)        | Note and print the number of tests to run                                      | The number of tests expected to run
[`tap_done_testing`](./src/plan.subr#L65) | Emit a plan if `tap_plan` wasn't called or check if the correct number of tests were run if so
[`tap_reset`](./src/plan.subr#L40)        | Reset Shmore's internal state
[`tap_BAIL_OUT`](./src/maybe.subr#L15)    | Stops all testing                                                              | _A Reason; arguments will be joined with `"$*"`_

Many functions take an optional file and line number.  This is usually done
with `$0` and `$LINENO`, e.g.
```sh
tap_ok $? "A thing worked" "$0" $LINENO
```

### Variables
In addition, two variables are provided

Name                                | Description
------------------------------------|------------
[`TAP_TODO`](./src/plan.subr#L14)   | When set, notes that tests are expected to fail
[`TAP_NOTRAP`](./src/plan.subr#L19) | When set before sourcing [`shmore.subr`](./shmore.subr), prevents `tap_done_testing` from being set as the `EXIT` trap.


Code Changes
------------
Change the files in [src](./src/) and then re-run `make` to re-assemble
[`shmore.subr`](./shmore.subr).  This is only really suppored on OpenBSD, but
will probably work on other OS's using BSD Make.  Alternatively, edit
`shmore.subr` directly.

Test with `make test` or `prove -It`.

Testing
-------
Tests are in [`t`](./t) and testable examples in [`examples`](./examples).

Shells which don't support
[`LINENO`](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#:~:text=LINENO)
(Like Debian's
[`sh`](https://manpages.debian.org/bookworm/dash/sh.1.en.html#:~:text=dash%20is%20a%20POSIX-compliant%20implementation%20of%20/bin/sh))
will cause large numbers of test failures, but these are more or less
false-positivish.  
