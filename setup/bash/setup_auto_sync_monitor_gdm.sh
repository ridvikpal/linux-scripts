#!/bin/bash

####################
# This script sets up systemd to automatically call the sync-monitor-gdm
# systemd unit files to automatically sync monitor changes with GDM
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# symlink the service file to the systemd system directory
echo "Symlinking sync-monitor-gdm.service..."
sudo ln -sf /home/ridvikpal/github/scripts/setup/systemd/sync-monitor-gdm.service /etc/systemd/system/sync-monitor-gdm.service

# symlink the path file to the systemd system directory
echo "Symlinking sync-monitor-gdm.path..."
sudo ln -sf /home/ridvikpal/github/scripts/setup/systemd/sync-monitor-gdm.path /etc/systemd/system/sync-monitor-gdm.path

# reload systemd so it recognizes the new files
echo "Reloading systemd..."
sudo systemctl daemon-reload

# enable the new systemd path file
echo "Enabling sync-monitor-gdm.path..."
sudo systemctl enable --now sync-monitor-gdm.path
