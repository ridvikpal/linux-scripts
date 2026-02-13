#!/bin/bash

####################
# This script is used to add custom root systemd unit files to a machine.
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# define reusable paths
REPO_PATH="/home/ridvikpal/github/linux-scripts"
SYSTEMD_PATH="/etc/systemd/system"

# symlink or copy your systemd unit files here

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
systemctl daemon-reload

# enable your systemd unit files here
