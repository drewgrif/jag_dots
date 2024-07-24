#!/bin/sh

updates=$(apt list --upgradable 2>/dev/null | grep -c 'upgradable')

if [ "$updates" -eq 0 ]; then
    echo "Up-to-date"
else
    echo "$updates updates"
fi
