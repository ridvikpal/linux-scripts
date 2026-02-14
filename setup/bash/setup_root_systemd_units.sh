#!/bin/bash

####################
# This script is used to add custom root-level systemd unit files to a machine.
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# define reusable paths
REPO_PATH="/home/ridvikpal/github/linux-scripts"
SYSTEMD_PATH="/etc/systemd/system"

# symlink the service file to the systemd system directory
echo "Symlinking sync-monitor-gdm.service..."
ln -sf "${REPO_PATH}/setup/systemd/sync-monitor-gdm.service" "${SYSTEMD_PATH}/sync-monitor-gdm.service"

# symlink the path file to the systemd system directory
echo "Symlinking sync-monitor-gdm.path..."
ln -sf "${REPO_PATH}/setup/systemd/sync-monitor-gdm.path" "${SYSTEMD_PATH}/sync-monitor-gdm.path"

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
systemctl daemon-reload

# enable the new systemd path file
echo "Enabling sync-monitor-gdm.path..."
systemctl enable --now sync-monitor-gdm.path
