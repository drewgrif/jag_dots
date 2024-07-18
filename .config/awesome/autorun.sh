#!/usr/bin/env bash

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# background
feh --bg-fill ~/.config/backgrounds/wallhaven-3l6g83_3440x1440.png &

# compositor
picom --animations -b &

# Notifications
dunst &
