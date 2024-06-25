#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Path to your custom text file
custom_bindings_file=~/.fluxbox/keybinds.txt

# Check if the custom file exists
if [ -f "$custom_bindings_file" ]; then
    # Display the content of the custom text file with lines in all uppercase displayed in red
    while IFS= read -r line; do
        if [[ "$line" == "${line^^}" ]]; then
            echo -e "${RED}${line}${NC}"
        else
            echo "$line"
        fi
    done < "$custom_bindings_file"
else
    echo "Custom bindings file not found: $custom_bindings_file"
fi

read
