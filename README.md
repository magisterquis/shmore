Shell [TAP](https://testanything.org) Producer 
==============================================
Little shell library for [testing anything](https://testanything.org).
More or less a Shell knockoff of Perl's
[Test::More](https://perldoc.perl.org/Test::More),
usable with [Prove](https://perldoc.perl.org/prove).

Just copy [`shmore.subr`](./shmore.subr)
([raw](https://raw.githubusercontent.com/magisterquis/shmore/refs/heads/master/shmore.subr))
somewhere and source it.

Tested with
- `ash` (Which may just be dash, on Debian)
- [`bash`](https://tiswww.case.edu/php/chet/bash/bashtop.html)
- [`dash`](http://gondor.apana.org.au/~herbert/dash/)
- `ksh` (Implementation varies)
- [`ksh93`](https://github.com/ksh93/ksh)
- [`mksh`](https://www.mirbsd.org/mksh.htm)
- [`posh`](https://salsa.debian.org/clint/posh)
- `sh` (Implementation varies)
- [`yash`](http://magicant.github.io/yash/)
- [`zsh`](https://zsh.sourceforge.io)

on OpenBSD, macOS, and most of
[DigitalOcean's Linux distros](https://docs.digitalocean.com/products/droplets/details/images/).
It should work elsewhere as well.

Examples are in [`./examples`](./examples), and have a look at [`wtrtdtmlb`'s
tests](https://github.com/magisterquis/wtrtdtmlb/tree/master/src/containers/jankins/t)
for IRL usage.

Example
-------
This test script
```sh
#!/bin/sh

set -euo pipefail # Works just fine

# Source shmore.
. ./shmore.subr

# Note how many tests will be run.  This isn't strictly necessary but gives us
# a warning if we inadvertently add or remove a test.  It also makes prove a
# bit less boring to watch.
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
[`tap_plan`](./src/plan.subr#L181)        | Note and print the number of tests to run                                      | The number of tests expected to run, or `0` to skip testing | _A Reason, if `$1` was `0`_
[`tap_done_testing`](./src/plan.subr#L75) | Emit a plan if `tap_plan` wasn't called or check if the correct number of tests were run if so
[`tap_reset`](./src/plan.subr#L46)        | Reset Shmore's internal state
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
[`TAP_TODO`](./src/plan.subr#L12)   | When set, notes that tests are expected to fail
[`TAP_NOTRAP`](./src/plan.subr#L17) | When set before sourcing [`shmore.subr`](./shmore.subr), prevents `tap_done_testing` from being set as the `EXIT` trap.


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

### Testing on other OSs
Testing on non-OpenBSD OSs probably won't work all that well with `make test`
but should work fine with `prove -It --directives`.

Alternatively, [`t/digitalocean`](./t/digitalocean) has support for spinning up
a handful of DigitalOcean Droplets for running tests on different Linux
distros.  If the stars align, it should be as simple as setting up
[`doctl`](https://docs.digitalocean.com/reference/doctl/) and, from this
directory, running
```sh
make spawn_droplets
make test
```
and then when the Droplets are no longer needed,
```sh
make clean_droplets
```
More or less anything POSIXish and SSHable can be used as well by adding a
file to [`t/digitalocean/t`](./t/digitalocean/t) with an SSH command to get to
it, e.g.
```sh
echo 'ssh -p 4444 test0r@10.3.4.5' > t/digitalocean/t/manual.ssh
```
Test output will be in files named `t/digitalocean/t/*.tout`.

Quirks
------
There are a few quirks to using this library which aren't obvious at first
glance.

1.  Subtests can't be run in a subshell, as there's no (good) way to ensure
    `tap_done_testing` is called or expose variables back to `tap_subtest`.
2.  Line numbers don't work on `dash` and presumably `ash`.
3.  Different shells have different ideas of what `$LINENO` and `$0` are in
    functions.
