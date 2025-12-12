#!/bin/bash

# Script to keep the laptop awake using systemd-inhibit and sleep

# Setup the reason for the inhibition.
# It will be visible in 'systemd-inhibit --list'.
INHIBIT_REASON="Running keep_awake.sh script"

# Inform the user the system is being inhibited
echo "Inhibiting the GNOME desktop session from locking, blanking or suspending"
echo "Reason: $INHIBIT_REASON"
echo "Press [Ctrl+C] to stop the script."
echo ""

# The systemd-inhibit command creates a lock.
# The 'sleep infinity' command keeps the script running indefinitely
# until manually interrupted (e.g., with Ctrl+C).
# The --why and --what flags provide context to the system.
# --what=idle: Prevents the screen from dimming or the system from idling.
# --what=sleep: Prevents system from going into suspend/hibernate.
# --what=shutdown: Prevents system from shutting down/rebooting.
gnome-session-inhibit \
    --reason "$INHIBIT_REASON" \
    --inhibit suspend:idle \
    --inhibit-only
