#!/bin/bash

####################
# This script is used to set laptop battery charge thresholds.
# Note this script has only been tested on a ThinkPad, which has a
# persistent EC, so writing to /sys permanently sets charge thresholds
# It may not work on other laptops
#
# It's also important to note that GNOME 48 now offers the capabilities this
# script provides out of the box via GNOME Settings, so this script is really
# only needed for older GNOME versions
####################

# first ensure the user is running this script as root
if [[ "${EUID}" -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# first define our battery id
BATTERY_ID="BAT0"

# first get the paths to the files we will be modifying
CHARGE_START_FILE="/sys/class/power_supply/${BATTERY_ID}/charge_control_start_threshold"
CHARGE_END_FILE="/sys/class/power_supply/${BATTERY_ID}/charge_control_end_threshold"
CHARGE_BEHAVIOUR_FILE="/sys/class/power_supply/${BATTERY_ID}/charge_behaviour"

# read the current charge thresholds
CHARGE_START=$(< "${CHARGE_START_FILE}")
CHARGE_END=$(< "${CHARGE_END_FILE}")

# inform the user of the current charge thresholds
echo "Current battery charge threshold settings:"
echo "Battery starts charging at ${CHARGE_START}%"
echo "Battery stops charging at ${CHARGE_END}%"
echo ""

# inform the user they have to select their preferred charge threshold
echo "Please select your preferred charge option:"
echo ""

# create the array of possible charge options
CHARGE_OPTIONS=(
    "Maximize battery runtime (96%-100%)"
    "Maximize battery lifespan (75%-80%)"
)

# prompt the user to select their preferred charge option
# and set the corresponding charge thresholds
select CHARGE_OPTION in "${CHARGE_OPTIONS[@]}"; do
    case $CHARGE_OPTION in
        "Maximize battery runtime (96%-100%)")
            echo 100 | tee "${CHARGE_END_FILE}" > /dev/null
            echo 96 | tee "${CHARGE_START_FILE}" > /dev/null
            break
            ;;
        "Maximize battery lifespan (75%-80%)")
            echo 75 | tee "${CHARGE_START_FILE}" > /dev/null
            echo 80 | tee "${CHARGE_END_FILE}" > /dev/null
            break
            ;;
        # handle edge case where they select invalid option
        *)
            # in this case, we will exit immediately for safety
            echo "Invalid choice."
            read -rp "Press any key to exit..."
            exit 1
            ;;
    esac
done

# make sure to set auto as the charge behaviour
# so the system follows the charge thresholds
echo auto | tee "${CHARGE_BEHAVIOUR_FILE}" > /dev/null

# read the new charge thresholds
CHARGE_START=$(< "${CHARGE_START_FILE}")
CHARGE_END=$(< "${CHARGE_END_FILE}")

# inform the user of the new charge thresholds
echo ""
echo "The battery threshold has been changed:"
echo "Battery starts charging at ${CHARGE_START}%"
echo "Battery stops charging at ${CHARGE_END}%"
echo ""
read -rp "Press any key to exit... " -n 1
echo ""
