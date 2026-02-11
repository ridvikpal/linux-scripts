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
# the ${GDM_CONFIG_PATH}/monitors.xml file
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# define reusable paths
GNOME_SHELL_CONFIG_PATH="/home/ridvikpal/.config"
GDM_CONFIG_PATH="/var/lib/gdm3/.config"

# define the GDM user, which can be found via grep gdm /etc/passwd
GDM_USER="Debian-gdm"

# Inform the user what the script is doing
echo "Copying GNOME Shell monitor configuration to GDM configuration"

# then copy the monitors.xml file to the gdm configuration directory
cp "${GNOME_SHELL_CONFIG_PATH}/monitors.xml" "${GDM_CONFIG_PATH}/"

# Update the permissions to ensure the copied monitors file is
# owned by the Debian-gdm user
chown "${GDM_USER}:${GDM_USER}" "${GDM_CONFIG_PATH}/monitors.xml"
