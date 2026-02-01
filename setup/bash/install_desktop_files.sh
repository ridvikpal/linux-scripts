#!/bin/bash

####################
# This script is used to install custom .desktop files found in this repo
# into the .local/share/applications directory

####################

REPO_PATH="/home/ridvikpal/github/scripts"
APPLICATION_PATH="/home/ridvikpal/.local/share/applications"

echo "Installing the .desktop file for keep_gnome_awake.sh"
ln -s "${REPO_PATH}/utilities/desktop/keep_gnome_awake.desktop" "${APPLICATION_PATH}/keep_gnome_awake.desktop"

echo "Installing the .desktop file for pc_to_ext_drive.sh"
ln -s "${REPO_PATH}/backup/desktop/pc_to_ext_drive.desktop" "${APPLICATION_PATH}/pc_to_ext_drive.desktop"

echo "Installing the .desktop file for phone_to_pc.sh"
ln -s "${REPO_PATH}/backup/desktop/phone_to_pc.desktop" "${APPLICATION_PATH}/phone_to_pc.desktop"
