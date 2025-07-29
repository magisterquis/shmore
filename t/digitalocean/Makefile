# Makefile
# Make ALL the Droplets
# By J. Stuart McMurray
# Created 20250225
# Last Modified 20250729

# Non-user-configurable varibales
CURRENT_SLUGS       !!= doctl compute image list-distribution\
			--format Slug --no-header | sort -u
BROKEN_SLUGS          = almalinux-8-x64
DEFAULT_SLUGS         = almalinux-9-x64\
			centos-stream-9-x64\
			debian-12-x64\
			fedora-41-x64 fedora-42-x64\
			rockylinux-8-x64 rockylinux-9-x64\
			ubuntu-22-04-x64 ubuntu-24-04-x64\
			ubuntu-24-10-x64 ubuntu-25-04-x64
DEFAULT_SSH_KEYS      = ${HOME}/.ssh_id_rsa ${HOME}/.ssh/id_ed25519\
			${HOME}/.ssh/id_ed25519_shmore
KNOWN_SLUGS           = almalinux-8-x64 almalinux-9-x64\
			centos-stream-9-x64\
			debian-12-x64\
			fedora-41-x64 fedora-42-x64\
			gpu-amd-base gpu-h100x1-base gpu-h100x8-base\
			rockylinux-8-x64 rockylinux-9-x64\
			ubuntu-22-04-x64 ubuntu-24-04-x64\
			ubuntu-24-10-x64 ubuntu-25-04-x64
SSH_SUFFIX            = ssh
SHMORE_DIR            = ../../
SSH_KEY_ID_FILE       = ${TEST_DIR}/ssh_key_id
SSH_TEST_DIR          = shmore_test
TEST_SUFFIX           = t
TEST_DIR              = ./t
TEST_CMD              = prove -It
TEST_TEMPLATE         = test.t.m4
TEST_OUT_SUFFIX       = tout

# Add in the local config
.include "config.mk"

# User-configurable variables
DROPLET_USER ?= shmore
NAME_PREFIX  ?= shmore-test-do
REGION       ?= fra1
SIZE         ?= s-1vcpu-1gb
SLUGS        ?= ${DEFAULT_SLUGS}
TAG          ?= shmore_test
USER_DATA    ?= ./droplet_user_data.sh

# We'll use a suffix rule to generate .tout files from .rsync files
.SUFFIXES: .${SSH_SUFFIX} .${TEST_SUFFIX}

# Work out our SSH key
.if empty(${SSH_KEY})
.	for F in ${DEFAULT_SSH_KEYS}
.		if exists($F)
SSH_KEY=$F
.		endif
.	endfor
.endif

spawn:: check_latest_images ## Spwan ALL the Droplets (default)
.PHONY: spawn

test: test_scripts ## Spawn Droplets as needed and run tests on them
	${TEST_CMD} --directives --jobs ${NTEST} --timer
.PHONY: test

# Create .t files from .ssh files.  We also include other .ssh files for just
# in case we want to add non-DigitalOcean Droplets eventually.
SSH_FILES !!= find ${TEST_DIR} -type f -name '*.${SSH_SUFFIX}'
TEST_SCRIPTS=${SSH_FILES:R:S/$/.${TEST_SUFFIX}/}

# Spawn a droplet and leave an SSH command in t/
.for SLUG in ${SLUGS}
SLUGF := ${TEST_DIR}/${NAME_PREFIX}-${SLUG}
${SLUGF}.${SSH_SUFFIX}: ${SSH_KEY_ID_FILE}
	@mkdir -p ${TEST_DIR}
	./spawn.sh\
		-i ${@F:S/${NAME_PREFIX}-//:R}\
		-K ${SSH_KEY}\
		-k ${SSH_KEY_ID}\
		-r ${REGION}\
		-s ${SIZE}\
		-t ${TAG}\
		-u ${DROPLET_USER}\
		-U ${USER_DATA}\
		${@F:R} >$@.tmp
	mv $@.tmp $@
spawn:: ${SLUGF}.${SSH_SUFFIX}
.endfor

# Roll t/*.t files from t/*.ssh, which actually happens in a suffix rule.
test_scripts:: ${TEST_SCRIPTS}
.PHONY: test_scripts
# Note every test script also depends on the macro file and the SSH file
.for F in ${TEST_SCRIPTS}
$F: ${TEST_TEMPLATE} ${F:R}.${SSH_SUFFIX}
.endfor
# NTEST is how many test scripts we (will) have, for parallel testing.
NTEST !!= echo ${TEST_SCRIPTS:QL} | tr ' ' '\n' | sort -u | wc -l | tr -d ' '

# Turn an SSH file into a test script.
.${SSH_SUFFIX}.${TEST_SUFFIX}:
	m4 -PEE\
		-Dm4_ssh=$<\
		-Dm4_remdir=${SSH_TEST_DIR}\
		-Dm4_testcmd=${TEST_CMD:Q}\
		-Dm4_name=${@F:R}\
		-Dm4_tout=${@:R}.${TEST_OUT_SUFFIX}\
		-Dm4_srcdir=${SHMORE_DIR}\
		${TEST_TEMPLATE} >$@.tmp
	mv $@.tmp $@

# Work out our SSH key's ID in DigitalOcean.
SSH_KEY_ID !!= cat ${SSH_KEY_ID_FILE}
.poison empty SSH_KEY_ID
${SSH_KEY_ID_FILE}:
	@mkdir -p ${TEST_DIR}
	@if [[ -z ${SSH_KEY} ]]; then\
		echo "Unable to guess SSH key" >&2\
		exit 2;\
	fi
	doctl compute ssh-key list -o json |\
		FP=$$(ssh-keygen -Emd5 -lf ${SSH_KEY} | cut -f 2 -d ' ')\
		jq --exit-status --raw-output '[.[] |\
		select("MD5:\(.fingerprint)" == $$ENV.FP)] | .[0].id' > $@.tmp
	mv $@.tmp $@

# Sometimes it's helpful to just be able to run the same command on all of the
# spawned droplets and other targets.
runcmd: ${SSH_FILES} ## Run the command COMMAND on all spawned Droplets
	@if [ -z "${COMMAND}" ]; then\
		echo "Please set COMMAND to a command to run." >&2;\
		exit 3;\
	fi
	@if [ -z "$>" ]; then\
		echo "No Droplets found in ${TEST_DIR}." >&2;\
		exit 4;\
	fi
.for F in ${SSH_FILES}
	@echo "----- ${F:T:R} -----"
	@$$(cat $F) ${COMMAND:Q}
.endfor
.PHONY: runcmd

nspawn: ## Print the number of Droplets which spawn spawns
	@echo ${SLUGS} | wc -w | tr -d ' '
.PHONY: spawn

# Make sure our idea of the DigitalOcean images is up-to-date.
check_latest_images:
	@if [[ ${KNOWN_SLUGS:Q} != ${CURRENT_SLUGS:Q} ]]; then\
		echo "Known distribution slug list out of date" >&2;\
		echo "  Known slugs: ${KNOWN_SLUGS}" >&2;\
		echo "Current slugs: ${CURRENT_SLUGS}" >&2;\
		exit 1;\
	fi
.PHONY: check_latest_images

clean_droplets: clean_tests ## Delete ALL the Droplets
	doctl compute droplet delete --force --tag-name ${TAG:Q}
	rm -f ${TEST_DIR}/${NAME_PREFIX}-*.${SSH_SUFFIX}
.PHONY: clean_droplets

clean_tests: ## Remove test scripts
.for F in ${TEST_SCRIPTS}
	rm -f ${F} ${F:R}.${TEST_OUT_SUFFIX}
.endfor
	rm -f ${TEST_DIR}/${NAME_PREFIX}-*.${TEST_SUFFIX}\
		${TEST_DIR}/${NAME_PREFIX}-*.${TEST_OUT_SUFFIX}
.PHONY: clean_tests

clean: clean_droplets clean_tests ## Delete droplets and temporary files
	rm -f ${SSH_KEY_ID_FILE} ${TEST_DIR}/*.tmp
.PHONY: clean

help: .NOTMAIN ## This help
	@perl -ne '/^(\S+?):+.*?##\s*(.*)/&&print"$$1\t-\t$$2\n"'\
		${MAKEFILE_LIST} | column -ts "$$(printf "\t")"
.PHONY: help
