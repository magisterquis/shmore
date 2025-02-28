Testing with [DigitalOcean](https://digitalocean.com)
=====================================================
This directory is a fairly overcomplicated way to spin up a bunch of
DigitalOcean Droplets for use in testing.

Assuming all the [Prerequisities](#Prerequisites) are met, it should be
sufficient to be in the root of the repo (the one with `shmore.subr`) and
run
```sh
make spawn_droplets
```
to create a bunch of tagged Droplets which will be used by `make test`.

When Droplets (and their associated costs) are no longer necessary,
```sh
make clean_droplets
```
from the root of this repo to remove them.

Output from tests on individual droplets can be found in [`./t`](./t) in files
named `*.tout`.

Prerequisites
-------------
For this to work, the following (probably) have to be met
- [`doctl`](https://docs.digitalocean.com/reference/doctl/)
- A DigitalOcean token, configured for `doctl`
- SSH key in `${HOME}/.ssh/id_ed25519_shmore`, `${HOME}/.ssh/id_ed25519`, or
  `${HOME}/.ssh/id_rsa`, usable with DigitalOcean
- OpenBSD's `make(1)`, or maybe `bmake(1)` on Linux.  Maybe
- OpenRsync (comes on OpenBSD)
- OpenBSD's `ksh(1)`, though other ksh's may work.  May
- [`jq`](https://jqlang.org)

On OpenBSD, aside from the DigitalOcean token, this is as simple as
```sh
go install github.com/digitalocean/doctl/cmd/doctl@latest
doas pkg_add jq
```

Configuration
-------------
User-serviceable parts live in [`config.mk`](./config.mk).  Especially handy
is `SLUGS=`, which allow for using a smaller subset of [`DigitalOcean Linux
distributions`](https://docs.digitalocean.com/products/droplets/details/images/).

Non-Droplet Remote Tests
------------------------
It's possible to run tests on non-DigitalOcean infrastructure by creating a
file in `./t` containing an SSH command and with a filename ending in `.ssh`,
e.g.
```sh
echo 'ssh -p 4444 test0r@10.3.4.5' > t/manual.ssh
# or t/digitalocean/t/manual.ssh, from the root of the repo.
```
When `make test` is run, `t/manual.t` will be created and after `make test` is
run `t/manual.tout` will be contain `prove(1)`'s output.
