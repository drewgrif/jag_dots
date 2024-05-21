#!/usr/bin/env bash

slstatus &

# network applet
# nm-applet &

# background
feh --bg-scale ~/.config/backgrounds/wallhaven-m3m2zm_3440x1440.png &

# compositor
picom --config ~/.config/picom/picom.conf &

# sxhkd
sxhkd -c ~/.config/suckless/sxhkd/sxhkdrc &

# Notifications
dunst &

# nextcloud
~/bin/Nextcloud-3.13.0-x86_64.AppImage &

# volume
# volumeicon &
