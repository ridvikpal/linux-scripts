#!/bin/bash

####################
# This script is used to add custom user systemd unit files to a machine.
####################

# define reusable paths
REPO_PATH="/home/ridvikpal/github/linux-scripts"
SYSTEMD_PATH="/home/ridvikpal/.config/systemd/user"

# Make the user systemd path if it doesn't exist already
mkdir -p "${SYSTEMD_PATH}"

# symlink the service file to the systemd system directory
echo "Symlinking set-display-temperature.service..."
ln -sf "${REPO_PATH}/setup/systemd/set-display-temperature.service" "${SYSTEMD_PATH}/set-display-temperature.service"

# symlink the path file to the systemd system directory
echo "Symlinking set-display-temperature.timer"
ln -sf "${REPO_PATH}/setup/systemd/set-display-temperature.timer" "${SYSTEMD_PATH}/set-display-temperature.timer"

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
systemctl --user daemon-reload

# enable the new systemd path file
echo "Enabling set-display-temperature.timer..."
systemctl --user enable --now set-display-temperature.timer
