#!/bin/sh

# Define variables
DISCORD_DIR="/opt/Discord"
DISCORD_BIN="/usr/bin/Discord"
DESKTOP_FILE="/usr/share/applications/discord.desktop"
TAR_FILE="discord.tar.gz"

# Function to clean up old Discord installation
cleanup() {
    echo "Cleaning up old Discord installation..."
    sudo rm -rf "$DISCORD_DIR"
    sudo rm -f "$DISCORD_BIN"
    sudo rm -f "$DESKTOP_FILE"
}

# Function to install or update Discord
install_discord() {
    echo "Retrieving the latest Discord tar.gz file..."
    wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O "$TAR_FILE"

    echo "Extracting files to /opt directory..."
    sudo tar -xvf "$TAR_FILE" -C /opt/
    rm "$TAR_FILE"

    echo "Creating symbolic link..."
    sudo ln -sf "$DISCORD_DIR/Discord" "$DISCORD_BIN"

    echo "Creating desktop entry..."
    cat > ./temp << "EOF"
[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=/usr/bin/Discord
Icon=/opt/Discord/discord.png
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin
EOF
    sudo cp ./temp "$DESKTOP_FILE"
    rm ./temp

    echo "Discord installation/update completed."
}

# Check if Discord is installed and clean up if necessary
if [ -d "$DISCORD_DIR" ] || [ -f "$DISCORD_BIN" ]; then
    cleanup
fi

# Install or update Discord
install_discord
