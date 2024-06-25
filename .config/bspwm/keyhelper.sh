#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Directory where the script is located
script_dir=$(dirname "$(realpath "$0")")

# Path to the custom text file (relative to the script's directory)
custom_bindings_file="$script_dir/keybinds.txt"

# Check if the custom file exists
if [ -f "$custom_bindings_file" ]; then
    # Pipe the content of the custom text file to less for paging with customized prompt
    cat "$custom_bindings_file" | {
        while IFS= read -r line; do
            if [[ "$line" == "${line^^}" ]]; then
                echo -e "${RED}${line}${NC}"
            else
                echo "$line"
            fi
        done
    } | less -R -P '[more]'
else
    echo "Custom bindings file not found: $custom_bindings_file"
fi
