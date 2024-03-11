#!/bin/bash

swaygrab -m -d -o | awk '{print $2 " " $3}' | read x y

if [[ $(echo "$x > $(swaymsg -t get_outputs | jq '.[0].current_mode.width') / 2" | bc) -eq 1 ]]; then
    swaymsg resize set width $(($x / 2))
else
    swaymsg resize set width -$(($x / 2))
fi

if [[ $(echo "$y > $(swaymsg -t get_outputs | jq '.[0].current_mode.height') / 2" | bc) -eq 1 ]]; then
    swaymsg resize set height $(($y / 2))
else
    swaymsg resize set height -$(($y / 2))
fi
