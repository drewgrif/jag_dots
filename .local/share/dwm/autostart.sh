#!/usr/bin/env bash

slstatus &

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

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
