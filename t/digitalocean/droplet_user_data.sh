#!/bin/sh
#
# droplet_user_data.sh
# Script to set up DigitalOcean Droplets for testing shmore
# By J. Stuart McMurray
# Created 20250220
# Last Modified 20250220

set -e
set -x

# SHELLS is the list of shells against which we'll test shmore.
SHELLS="ash bash dash ksh ksh93 ksh93u+m mksh posh yash zsh"
# TESTUSER is the name of the non-root user we'll use for testing.
TESTUSER=shmore

# Add some swap space.
truncate -s 0 /swapfile
if [ "btrfs" = "$(df --output=fstype /swapfile | tail -n 1)" ]; then
        chattr +C /swapfile
fi
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo /swapfile swap swap defaults 0 0 >> /etc/fstab


# Make a non-root user for testing.
useradd -m $TESTUSER
mkdir /home/$TESTUSER/.ssh
chmod 0700 /home/$TESTUSER/.ssh
cp /root/.ssh/authorized_keys /home/$TESTUSER/.ssh/authorized_keys
chmod 0600 /home/$TESTUSER/.ssh/authorized_keys
chown -R $TESTUSER:$(id -g $TESTUSER) /home/$TESTUSER/.ssh

# Install shells to test against and test dependencies.
TOINSTALL="perl rsync"
if which apt >/dev/null 2>&1; then # Debianish
        export DEBIAN_FRONTEND=noninteractive
        apt-get -y -qq update
        apt-get -y -qq upgrade
        for s in $SHELLS; do
                if apt-cache show "$s" | head -n 1 | egrep -q '^Package: '; then
                        TOINSTALL="$TOINSTALL $s"
                fi
        done
        apt-get -y -qq install $TOINSTALL
        apt-get -y -qq autoremove
elif which yum >/dev/null; then # Redhatish
        yum -y -q clean packages
        yum -y -q update
        for s in $SHELLS; do
                if yum -q list "$s" >/dev/null; then
                        TOINSTALL="$TOINSTALL $s"
                fi
        done
        yum -y -q install $TOINSTALL
else
        echo "Unknown package installer" >&2
        exit 1
fi

# Make sure prereqs installed.
type prove rsync
