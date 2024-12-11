#!/bin/bash

sudo su

/lib/systemd/systemd

export TERM=xterm

export DELUGE_VERSION="master"

SEEDBOX_USER="seedbox"
SEEDBOX_PASS="password"

bash <(curl -sL git.io/swizzin) --unattend nginx panel deluge btsync radarr lidarr --user $SEEDBOX_USER --pass $SEEDBOX_PASS

unset SEEDBOX_PASS

# Fix ownership and permissions for mounted directories
chown -R seedbox:seedbox /home/seedbox
chmod -R 700 /home/seedbox

# Start systemd
exec /lib/systemd/systemd