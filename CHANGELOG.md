Changelog
=========

20250613
--------
- Don't elide blank lines in output.
- Updated DigitalOcean known slugs list.

20250430
--------
- Switch to using `/bin/echo` instead of the shells' `echo` to prevent escape
  character silliness.

20250312
--------
- Cache Perl's output in [`t/same_output.t`](./t/same_output.t) to cut testing
  time down quite a bit.

20250310
--------
- `tap_subtest`: Don't print double failure counts if `tap_done_testing` is
  called in an `EXIT` trap.

20250309
--------
- Handle DigitalOcean Droplet IP address reuse better.
- Minor [README](./README.md) and [quickstart](examples/quickstart.t)
  improvements.

20250308
--------
- Everything works with `set -euo pipefail` now!
- Make this changelog pass the no-DEBUG test.
- Testing on remote hosts is a bit less boring to watch.
- Assorted improvements to tests.

20250302
--------
- Add a test to make sure we've no `DEBUG`s lying about.
- `tap_cmp_ok`: Don't quote numbers.
- Match `Test::More`'s formatting and error messages more closely.
- Rework tests to group by test file, not shell.
- Note missing shells during testing.
- Added `make clean` and `make help`.
- Test on several more shells.
- Avoid failing scripts exiting with status 0.
- Don't unfail a failing script if there's neither tests nor plan.
- New homegrown, over-engineered CI pipeline using DigitalOcean.
- Work around ancient Zsh and macOS' ancient buggy bash.
- Allow for `tap_plan 0` to indicate a skipped script.
- Assorted improvements to tests.

20250202
--------
- Documentation update to NOT use subshells for functions.

20250201
--------
- Added a [changelog](./CHANGELOG.md)
- Added a link to the raw version of [`shmore.subr`](./shmore.subr).
- ~`tap_BAIL_OUT`: Also work in subtests in subshells.~
- `tap_diag`/`tap_note`: Handle multiple arguments better.
- `tap_diag`/`tap_note`: Handle multiple lines better.
- `tap_diag`/`tap_note`: No more unexpected wildcard expansion.
- `tap_ok`: Require arguments now.
- Documentation fixes.
