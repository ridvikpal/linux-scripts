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

echo "Copying GNOME Shell monitor configuration to GDM configuration"

# then copy the monitors.xml file to the gdm configuration directory
sudo cp /home/ridvikpal/.config/monitors.xml /var/lib/gdm3/.config/

# Update the permissions to ensure the copied monitors file is
# owned by the Debian-gdm user
sudo chown Debian-gdm:Debian-gdm /var/lib/gdm3/.config/monitors.xml
