#!/bin/ksh
#
# spawn.sh
# Spawn a Droplet
# By J. Stuart McMurray
# Created 20250225
# Last Modified 20250228

set -euo pipefail

# usage prints a help message.
function usage {
        cat <<_eof
Usage: $(basename "$0") [options] name

Spins up a new Droplet with the given name and waits for cloud-init to finish.

Options:
h - Print this help
i - Droplet image slug (required)
K - SSH key file (required)
k - SSH key ID (required)
r - DigitalOcean region
s - Droplet size
t - Droplet tag
U - User-data script
u - Post-cloud-init Droplet username
_eof
}

# Argument-parsing
while getopts hi:K:k:r:s:t:u:U: name; do
        case $name in
                h) usage; exit 0        ;;
                i) IMAGE=$OPTARG        ;;
                K) SSH_KEY_FILE=$OPTARG ;;
                k) SSH_KEY_ID=$OPTARG   ;;
                r) REGION=$OPTARG       ;;
                s) SIZE=$OPTARG         ;;
                t) TAG=$OPTARG          ;;
                u) DROPLET_USER=$OPTARG ;;
                U) USER_DATA=$OPTARG  ;;
                ?) usage >&2; exit 1    ;;
        esac
done
shift $(($OPTIND - 1))

# Make sure we have the bits we need.
if [[ -z "${IMAGE:-""}" ]]; then
        echo "Need an image slug (-i)" >&2
        exit 4
fi
if [[ -z "${NAME:=$1}" ]]; then
        echo "Need a Droplet name" >&2
        exit 2
fi
if [[ -z "${SSH_KEY_FILE:-""}" ]]; then
        echo "Need an SSH key file (-K)" >&2
        exit 7
fi
if [[ -z "${SSH_KEY_ID:-""}" ]]; then
        echo "Need an SSH key ID (-k)" >&2
        exit 3
fi
if [[ -z "${DROPLET_USER:-""}" ]]; then
        echo "Need a post-cloud-init Droplet username" >&2
        exit 11
fi

# Logs logs $@, timestamped
function log { echo "[$NAME] $(date) -- $@" >&2; }

# Spin up the Droplet itself
CMD="doctl compute droplet create \
--droplet-agent=true \
--enable-monitoring \
--image $IMAGE \
--output json \
--region ${REGION-} \
--size ${SIZE-} \
--ssh-keys $SSH_KEY_ID \
--tag-name ${TAG:-} \
--user-data-file ${USER_DATA:-} \
--wait \
$NAME"
log "Creating Droplet: $CMD"

export DO_JSON=$($CMD)
if jq --exit-status --null-input\
        '$ENV.DO_JSON | fromjson | "object" == type' >/dev/null; then
        log "Error making Droplet: $(jq \
                --null-input '$ENV.DO_JSON | fromjson | .errors[]')">&2;
        exit 6
fi

# Delete the Droplet on error
MADE_OK=
trap 'if [[ -z "$MADE_OK" ]]; then
        log "Removing Droplet due to interrupt or earlier errors";
        doctl compute droplet delete --verbose --force "$NAME";
fi' EXIT

# Grab the Droplet IP address and make sure we don't think we know its SSH key.
DROPLET_IP=$(jq --null-input --raw-output \
        '$ENV.DO_JSON | fromjson | .[0].networks.v4[] |
                select("public" == .type) |
                .ip_address')
if [[ -z "$DROPLET_IP" ]]; then
        log "No IP address for Droplet"
        exit 9
fi
if ssh-keygen -F "$DROPLET_IP"; then
        # A bit racy, but should be fine.
        log "Removing stale known_hosts entry"
        ssh-keygen -R $DROPLET_IP >/dev/null
fi

# Command to SSH as root
ROOT_SSH="ssh -i $SSH_KEY_FILE root@$DROPLET_IP"
# Wait until the box is up.
log "Droplet created with IP $DROPLET_IP, waiting for SSH: $ROOT_SSH"
set +o pipefail # We expect SSH to fail here
while $ROOT_SSH \
        -oConnectTimeout=5 \
        -oStrictHostKeyChecking=accept-new \
        /bin/true 2>&1 |
        egrep -q 'ssh: connect to host [[:digit:].]+ port 22: '\
'(Connection refused|Operation timed out)'; do
        sleep 1
done
set -o pipefail # We no longer expect SSH to fail

# Make sure cloud-init finishes ok.
log "Droplet responds to SSH, waiting for cloud-init to finish"
if ! $ROOT_SSH 'cloud-init status --wait >/dev/null'; then\
        log "Cloud-init failed:"
        $ROOT_SSH tail -n 20 /var/log/cloud-init-output.log | while read; do
                log "$REPLY";
        done
        exit 10
fi

# Make sure we have a non-root user
log "Cloud-init finished, ensuring user $DROPLET_USER can log in"
USER_SSH="ssh -i $SSH_KEY_FILE -oConnectTimeout=5 "\
"-oServerAliveInterval=10 -oServerAliveCountMax=3 "\
"$DROPLET_USER@$DROPLET_IP"
WHOIAM="$($USER_SSH whoami)"
if [[ "$WHOIAM" != "$DROPLET_USER" ]]; then
        log "User is not $DROPLET_USER: $WHOIAM"
        exit 13
fi

# All done :)
log "Droplet ready: $USER_SSH"
MADE_OK="yes :)"
echo "$USER_SSH"
