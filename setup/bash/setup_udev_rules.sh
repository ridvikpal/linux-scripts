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
REPO_PATH="/home/ridvikpal/github/linux-scripts"
UDEV_PATH="/etc/udev"

# symlink the usb wakeup udev rule
echo "Symlinking 90-disable-usb-wakeup.rules..."
ln -sf "${REPO_PATH}/setup/udev/90-disable-usb-wakeup.rules" "${UDEV_PATH}/rules.d/90-disable-usb-wakeup.rules"

# symlink the thinkpad keys remap udev hwdb rule
echo "Symlinking 80-thinkpad-keys-remap.hwdb..."
ln -sf "${REPO_PATH}/setup/udev/80-thinkpad-keys-remap.hwdb" "${UDEV_PATH}/hwdb.d/80-thinkpad-keys-remap.hwdb"

# reload the udev rules
echo "Reloading udev rules..."
systemd-hwdb update
udevadm control --reload-rules
udevadm trigger
