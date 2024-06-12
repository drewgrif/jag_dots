#!/bin/bash

muted=$(pacmd list-sinks | awk '/muted/ { print $2 }')
vol=$(pactl list sinks | awk '/Volume:/ {printf "%s ",$5}' | cut -f1 -d ' ' | cut -f1 -d '%')

if [[ $muted = "no" ]]; then
	if [[ $vol -ge 65 ]]; then
		echo ~/.config/tint2/executors/icons/audio-volume-high.svg
		echo "$vol%"
	elif [[ $vol -ge 40 ]]; then
			echo ~/.config/tint2/executors/icons/audio-volume-medium.svg
			echo "$vol%"
	elif
	       [[ $vol -ge 0 ]]; then
       			echo ~/.config/tint2/executors/icons/audio-volume-low.svg
	 		echo "$vol%"		
	fi
else
	echo ~/.config/tint2/executors/icons/audio-volume-muted.svg
	echo "muted"
fi
