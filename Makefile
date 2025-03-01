# Makefile
# Test shmore
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250301

# Directory for spawining and testing with DigitalOcean droplets (not default).
DO_DIR    = ./t/digitalocean
DO_MAKE   = ${.MAKE} -C ${DO_DIR}
DO_SSH  !!= find ${DO_DIR}/t -type f -name "*.$$(${DO_MAKE} -V SSH_SUFFIX)"

all: shmore.subr test ## Build and test shmore.subr (default)

# Assemble the main library
shmore.subr: src/readsrc.awk src/*.subr src/header.m4 ## Build shmore.subr
	m4 -PEE ${>:M*.m4} >$@.tmp
	awk -f ${>:M*.awk} ${>:M*.subr} >>$@.tmp
	echo '# vim: ft=sh' >>$@.tmp
	mv $@.tmp $@

test: shmore.subr ## Test ALL the shmores!
	prove -It examples/
	prove -It --directives
.if ! empty(DO_SSH)
	${DO_MAKE} test
.endif
.PHONY: test

# Things for testing on remote boxen
spawn_droplets: ## Spawn a bunch of DigitalOcean Droplets for remote testing
	${DO_MAKE} -j $$(${DO_MAKE} nspawn)
clean_droplets: ## Delete Droplets spawned with spawn_droplets
	${DO_MAKE} clean
.PHONY: spawn_droplets clean_droplets

clean: clean_droplets ## Remove the built shmore.subr and any spawned Droplets
	rm -f shmore.subr
.PHONY: clean

help: .NOTMAIN ## This help
	@perl -ne '/^(\S+?):+.*?##\s*(.*)/&&print"$$1\t-\t$$2\n"' \
		${MAKEFILE_LIST} | column -ts "$$(printf "\t")"
.PHONY: help
