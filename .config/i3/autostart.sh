
# Autostart applications
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# bar start
~/.config/i3/polybar-i3 &

# wallpaper
feh --bg-fill ~/.config/backgrounds/wallhaven-578rw7_3440x1440.png &

# compositor and notifications
picom --animations -b &
# numlockx on &
dunst &
# blueman-applet &

# sxhkd
sxhkd -c ~/.config/i3/sxhkdrc &
