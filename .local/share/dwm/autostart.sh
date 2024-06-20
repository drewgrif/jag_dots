#!/usr/bin/env bash

slstatus &

# network applet
# nm-applet &

# background
feh --bg-scale ~/.config/backgrounds/wallhaven-m3m2zm_3440x1440.png &

# compositor
picom --animations -b &

# sxhkd
# (re)load sxhkd for keybinds
if hash sxhkd >/dev/null 2>&1; then
	pkill sxhkd
	sxhkd -c "$HOME/.config/suckless/sxhkd/sxhkdrc" &
fi

# Notifications
dunst &

# nextcloud
# ~/bin/Nextcloud-3.13.0-x86_64.AppImage &

# volume
# volumeicon &
