#!/bin/bash

####################
# This script is used to setup gammastep for automatically setting
# the display temperature
####################

# store our gammastep config folder path
GAMMASTEP_CONFIG_FOLDER_PATH="/home/ridvikpal/.config/gammastep"

# create the gammastep config folder if it doesn't exist
mkdir -p "${GAMMASTEP_CONFIG_FOLDER_PATH}"

# write the gammastep config to the config.ini configuration file
echo "Writing gammastep config.ini file..."
cat <<EOF > "${GAMMASTEP_CONFIG_FOLDER_PATH}/config.ini"
[general]
; set the day and night temperatures
temp-day=6500
temp-night=3000

; set the times to transition
dawn-time=6:59-7:00
dusk-time=18:59-19:00

; set the transition to fade
fade=1

; use the randr adjustment method
; optimal for x11
adjustment-method=randr
EOF

# run gammastep indicator to start gammastep immediately
gammastep-indicator &

# inform the user how to autostart gammastep
echo "gammastep is setup correctly. Please right click the gammastep icon in the status bar and select "Autostart" to make it automatically start."
