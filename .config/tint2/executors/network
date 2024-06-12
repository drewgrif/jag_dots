#!/bin/bash

connection=$(nmcli d | awk 'FNR == 2 {print $2}')
state=$(nmcli d | awk 'FNR == 2 {print $3}')

if [ $connection == "ethernet" ]; then
	if [ $state == "connected" ]; then
		echo ~/.config/tint2/executors/icons/network-wired.svg
		echo "up"
	else
		echo ~/.config/tint2/executors/icons/network-wired-offline.svg
		echo "down"
	fi
elif [ $connection == "wifi" ]; then
	if [ $state == "connected" ]; then
		echo ~/.config/tint2/executors/icons/network-wireless-signal-excellent-symbolic.svg
		echo "up"
	else 
		echo ~/.config/tint2/executors/icons/network-wireless-offline-symbolic.svg
		echo "down"
	fi
fi
