Simple Test AnytHing protocol Producer
======================================
For when [Shmore](./shmore.subr) is too big, there's [Stahp](./stahp.subr).

Just copy [`stahp.subr`](./stahp.subr)
([raw](https://raw.githubusercontent.com/magisterquis/shmore/refs/heads/master/stahp.subr))
somewhere and source it.

Have a look at [`examples/stahp.t`](./examples/stahp.t) for an example.

API
---
Stahp provides four functions.  All may be used without arguments.

### [`stahp_plan`](./stahp.subr#L9)
A multi-purpose function which can be used to...

1.  Print a test plan (`1..N`) before testing, by providing a count.  This is
    the way to go most of the time.
    ```sh
    stahp_plan 4 # Prints 1..4, to tell the harness to expect four tests.
    ```
2.  Note how many tests were run after testing is finished.
    ```sh
    # Run a couple of tests
    stahp_pass "A passing test"
    stahp_fail "A failing test"
    stahp_plan # Prints 1..2, indicating two tests have run
    ```
3.  Mark the test script as to be skipped.
    ```sh
    stahp_plan 0 # Prints 1..0
    ```
4.  Mark the test script as to be skipped with an explanation.
    ```sh
    stahp_plan 0 "# SKIP Not now, nope" # Prints 1..0 # SKIP Not now, nope
    ```

It's possible to run it via `trap stahp_plan EXIT`, but this is generally not a
good idea as it makes detecting errors that much harder.

### [`stahp_ok`](./stahp.subr#L18)
Notes whether or not the previous exited with a status of 0 (i.e. `$?` was
`0`) along with a test name, if provided.  Tests which indicate failures (i.e.
`$?` wasn't `0`) will also print a message to stderr for nicer `prove(1)`
output.

Example:
```sh
/bin/true
stahp_ok                # Prints ok 1

/bin/true
stahp_ok "A happy test" # Prints ok 2 - A happy test

/bin/false
stahp_ok                # Prints not ok 2 (plus a message to stderr)

/bin/false
stahp_ok "A sad test"   # Prints not ok 2 - A sad test (plus a message to stderr)
```

### [`stahp_pass`](./stahp.subr#L38) and [`stahp_fail`](./stahp.subr#L44)
Wrappers around [`stahp_ok`](#stahp_ok) which note a test passed or failed
regardless of the value of `$?`.  Also take an optional test name.

Example:
```sh
stahp_pass                # Prints ok 1
/bin/false
stahp_pass "A happy test" # Prints ok 2 - A happy test
/bin/true
stahp_fail                # Prints not ok 3 (plus a message to stderr)
stahp_fail "A sad test"   # Prints not ok 4 - A sad test (plus a message to stderr)
```
