#!/bin/sh

slstatus &

# network applet
nm-applet &

# background
feh --bg-scale ~/.config/backgrounds/debianpaint.png &

# compositor
picom --config ~/.config/picom/picom.conf &

# sxhkd
sxhkd -c ~/.config/suckless/sxhkd/sxhkdrc &

# Notifications
dunst &

# volume
volumeicon &
