# config.mk
# User-settable settings
# By J. Stuart McMurray
# Created 20250223
# Last Modified 20250228

# DROPLET_USER is the username used when generating Droplet SSH commands.  It
# will likely need to be made by ${USER_DATA}.
#DROPLET_USER = shmore

# NAME_PREFIX plus a hyphen is prefixed to Droplet image slugs to make
# Droplets' names.
#NAME_PREFIX = shmore-test-do

# REGION is the DigitalOcean region in which Droplets are created.
#REGION = fra1

# SIZE is the size of created Droplets.
#SIZE = s-1vcpu-1gb

# SLUGS are the list of distribution slugs for which to spin up Droplets.  It
# is most of what's available, minus AI/ML distributions and a couple of
# poorly-supported RedHat derivatives
#SLUGS = ${DEFAULT_SLUGS}

# SSH_KEY is the SSH key file to use, or a reasonable default if unset.
#SSH_KEY =

# TAG is used to tag and delete created Droplets.
#TAG = shmore_test

# USER_DATA is the script which sets up Droplets.
#USER_DATA = ./droplet_user_data.sh
