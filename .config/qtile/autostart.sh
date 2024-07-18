#!/bin/sh
# nm-applet &

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# background
feh --bg-fill ~/.config/backgrounds/debdino.png &

# compositor
picom --animations -b &

# sxhkd
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Notifications
dunst &
