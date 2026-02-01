#!/bin/bash

####################
# This script is used to add custom systemd unit files to a machine.
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

REPO_PATH="/home/ridvikpal/github/scripts"
SYSTEMD_PATH="/etc/systemd/system"

# symlink the service file to the systemd system directory
echo "Symlinking sync-monitor-gdm.service..."
sudo ln -sf "${REPO_PATH}/setup/systemd/sync-monitor-gdm.service" "${SYSTEMD_PATH}/sync-monitor-gdm.service"

# symlink the path file to the systemd system directory
echo "Symlinking sync-monitor-gdm.path..."
sudo ln -sf "${REPO_PATH}/setup/systemd/sync-monitor-gdm.path" "${SYSTEMD_PATH}/sync-monitor-gdm.path"

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
sudo systemctl daemon-reload

# enable the new systemd path file
echo "Enabling sync-monitor-gdm.path..."
sudo systemctl enable --now sync-monitor-gdm.path
