# Makefile
# Test shmore
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250222

all: shmore.subr test ## Build and test shmore.subr (default)

# Assemble the main library
shmore.subr: src/readsrc.awk src/*.subr src/header.m4 ## Build shmore.subr
	m4 -PEE ${>:M*.m4} >$@.tmp
	awk -f ${>:M*.awk} ${>:M*.subr} >>$@.tmp
	echo '# vim: ft=sh' >>$@.tmp
	mv $@.tmp $@

test: shmore.subr ## Test ALL the shmores!
	prove -It examples/
	prove -It --directives t/
.PHONY: test

clean: ## Remove the built shmore.subr
	rm -f shmore.subr

help: .NOTMAIN ## This help
	@perl -ne '/^(\S+?):+.*?##\s*(.*)/&&print"$$1\t-\t$$2\n"' \
		${MAKEFILE_LIST} | column -ts "$$(printf "\t")"
.PHONY: help
