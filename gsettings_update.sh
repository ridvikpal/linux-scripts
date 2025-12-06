#!/bin/bash

# set the background to black
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#000000'

# disable touchpad and trackpoint acceleration
gsettings set org.gnome.desktop.peripherals.touchpad accel-profile 'flat'
gsettings set org.gnome.desktop.peripherals.pointingstick accel-profile 'flat'

# disable conflicting VS Code copy line up/down keyboard shortcuts
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down ['']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up ['']

# In case you ever want to reenable these GNOME keyboard shortcuts:
#gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down ['<Control><Shift><Alt>Down']
#gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up ['<Control><Shift><Alt>Up']
