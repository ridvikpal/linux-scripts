#!/bin/bash

####################
# This script copies your GNOME Shell monitor configuration to
# the gdm configuration folder on Debian
# so that both monitor configurations (e.g., scaling) is synced
#
# If you're using another Linux distro, you can find your gdm config folder
# via grep gdm /etc/passwd
#
# In case you ever want to reset the gdm configuration, just delete
# the /var/lib/gdm3/.config/monitors.xml file
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

GNOME_SHELL_CONFIG_PATH="/home/ridvikpal/.config"
GDM_CONFIG_PATH="/var/lib/gdm3/.config"
GDM_USER="Debian-gdm"

echo "Copying GNOME Shell monitor configuration to GDM configuration"

# then copy the monitors.xml file to the gdm configuration directory
sudo cp "${GNOME_SHELL_CONFIG_PATH}/monitors.xml" "${GDM_CONFIG_PATH}/"

# Update the permissions to ensure the copied monitors file is
# owned by the Debian-gdm user
sudo chown "${GDM_USER}:${GDM_USER}" "${GDM_CONFIG_PATH}/monitors.xml"
