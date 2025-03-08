Changelog
=========

20250308
--------
- Make this changelog pass the no-DEBUG test.

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
