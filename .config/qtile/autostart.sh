#!/bin/sh
# nm-applet &

# background
feh --bg-fill ~/.config/backgrounds/debdino.png &

# compositor
picom --config ~/.config/picom/picom.conf &

# sxhkd
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Notifications
dunst &

