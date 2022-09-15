
# Autostart applications
# /usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1 &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore; sleep 1; 
# feh ~/.config/backgrounds/wallhaven-2kjegy_3440x1440.png &
picom -b &
numlockx on &
nm-applet &
volumeicon &
dunst &
# blueman-applet &

# sxhkd
sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &
