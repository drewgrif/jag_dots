#!/bin/sh
nm-applet &

# background
feh --bg-scale ~/Pictures/blueguitar.jpg &

# compositor
picom --config ~/.config/picom/picom.conf &

# sxhkd
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Notifications
dunst &

