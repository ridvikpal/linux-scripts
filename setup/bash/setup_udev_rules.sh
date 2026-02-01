#!/bin/bash

####################
# This script is used to add custom udev rules to a linux machine
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# define reusable paths
REPO_PATH="/home/ridvikpal/github/scripts"
UDEV_PATH="/etc/udev/rules.d"

# symlink the usb wakeup rules udev rule
echo "Symlinking 90-disable-usb-wakeup.rules..."
sudo ln -sf "${REPO_PATH}/setup/udev/90-disable-usb-wakeup.rules" "${UDEV_PATH}/90-disable-usb-wakeup.rules"

# reload the udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger
