# Makefile
# Test shmore
# By J. Stuart McMurray
# Created 20241105
# Last Modified 20250218

all: shmore.subr test

# Assemble the main library
shmore.subr: src/readsrc.awk src/*.subr src/header.m4
	m4 -PEE ${>:M*.m4} >$@.tmp
	awk -f ${>:M*.awk} ${>:M*.subr} >>$@.tmp
	echo '# vim: ft=sh' >>$@.tmp
	mv $@.tmp $@

test: shmore.subr
	prove -It examples/
	prove -It --directives t/

.PHONY: test
