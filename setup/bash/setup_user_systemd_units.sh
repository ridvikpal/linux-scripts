#!/bin/bash

####################
# This script is used to add custom user-level systemd unit files to a machine.
####################

# define reusable paths
REPO_PATH="/home/ridvikpal/github/linux-scripts"
SYSTEMD_PATH="/home/ridvikpal/.config/systemd/user"

# Make the user systemd path if it doesn't exist already
mkdir -p "${SYSTEMD_PATH}"

# symlink or copy your systemd unit files here

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
systemctl --user daemon-reload

# enable your systemd unit files here
