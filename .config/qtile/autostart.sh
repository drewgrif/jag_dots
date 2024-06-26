#!/bin/sh
# nm-applet &

# background
feh --bg-fill ~/.config/backgrounds/debdino.png &

# compositor
picom --animations -b &

# sxhkd
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Notifications
dunst &

