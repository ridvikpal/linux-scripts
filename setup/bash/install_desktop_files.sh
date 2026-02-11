#!/bin/bash

####################
# This script is used to install custom .desktop files found in this repo
# into the Desktop directory to quickly launch them.
####################

# define reusable paths
REPO_PATH="/home/ridvikpal/github/scripts"
DESKTOP_PATH="/home/ridvikpal/Desktop"

# install the desktop file for pc_to_ext_drive.sh
echo "Symlinking the .desktop file for pc_to_ext_drive.sh"
ln -sf "${REPO_PATH}/backup/desktop/pc_to_ext_drive.desktop" "${DESKTOP_PATH}/pc_to_ext_drive.desktop"

# install the desktop file for phone_to_pc.sh
echo "Symlinking the .desktop file for phone_to_pc.sh"
ln -sf "${REPO_PATH}/backup/desktop/phone_to_pc.desktop" "${DESKTOP_PATH}/phone_to_pc.desktop"
