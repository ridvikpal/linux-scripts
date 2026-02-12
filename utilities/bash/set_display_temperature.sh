#!/bin/bash

####################
# This script is used to set the display temperature based
# on the hour of the day.
####################

HOUR=$(date +%H)

# If it's between 7 AM and 7 PM (07:00 - 18:59)
if [ "$HOUR" -ge 7 ] && [ "$HOUR" -lt 19 ]; then
    echo "Setting display temperature to day mode"
    xsct 0
else
    echo "Setting display temperature to night mode"
    xsct 2500
fi
