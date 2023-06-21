#!/bin/sh
nm-applet &

# background
feh --bg-scale ~/.config/backgrounds/Wallpaperkiss_1208315.jpg &

# compositor
picom --config ~/.config/picom/picom.conf &

# sxhkd
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Notifications
dunst &

