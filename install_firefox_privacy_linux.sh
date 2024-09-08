#!/bin/bash

# Cross-platform Firefox Privacy & Security Setup Script (Linux Version)

# Define colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color
LOG_FILE="firefox_privacy_setup.log"

# Function to update the system and install prerequisites
update_system() {
    echo -e "${GREEN}Updating system and installing prerequisites...${NC}"
    sudo apt update && sudo apt upgrade -y
    sudo apt install wget curl unzip git -y
    echo "System updated and required tools installed." >> "$LOG_FILE"
}

# Firefox profile directory finder
get_firefox_profile() {
    echo "Finding your Firefox profile directory..."
    PROFILE_PATH=$(find ~/.mozilla/firefox/*.default-release -type d 2>/dev/null | head -n 1)
    if [ -z "$PROFILE_PATH" ]; then
        echo "Profile directory not found. Make sure Firefox is installed and you have a profile."
        exit 1
    fi
    echo -e "${GREEN}Profile directory found: $PROFILE_PATH${NC}"
    echo "Profile path: $PROFILE_PATH" >> "$LOG_FILE"
}

# Download and apply Arkenfox user.js
install_arkenfox_userjs() {
    echo "Downloading Arkenfox user.js..."
    wget -q https://raw.githubusercontent.com/arkenfox/user.js/master/user.js -O "$PROFILE_PATH/user.js"
    echo -e "${GREEN}Arkenfox user.js has been applied.${NC}"
    echo "Arkenfox user.js applied to $PROFILE_PATH" >> "$LOG_FILE"
}

# Function to automatically install Firefox extensions
install_extensions() {
    EXTENSIONS=(
        "ublock-origin@raymondhill.net"
        "https-everywhere@eff.org"
        "decentraleyes@libreops.cc"
        "cookie-autodelete@kennydo.com"
        "noscript@noscript.net"
        "privacybadger@eff.org"
        "clearurls@kevinroebert.de"
        "canvasblocker@kkapsner.de"
        "trace@absolutedouble.co.uk"
    )
    echo "Installing Firefox extensions..."
    for EXT in "${EXTENSIONS[@]}"; do
        EXTENSION_URL="https://addons.mozilla.org/firefox/downloads/latest/$EXT/addon-$EXT-latest.xpi"
        wget "$EXTENSION_URL" -P /tmp/
        firefox /tmp/addon-$EXT-latest.xpi &
        sleep 5
    done
    echo -e "${GREEN}Extensions installed.${NC}"
    echo "Installed extensions: ${EXTENSIONS[*]}" >> "$LOG_FILE"
}

# Apply about:config settings for privacy
apply_about_config() {
    echo "Applying custom about:config settings..."
    echo 'user_pref("media.peerconnection.enabled", false);' >> "$PROFILE_PATH/user.js"
    echo 'user_pref("webgl.disabled", true);' >> "$PROFILE_PATH/user.js"
    echo 'user_pref("geo.enabled", false);' >> "$PROFILE_PATH/user.js"
    echo 'user_pref("privacy.firstparty.isolate", true);' >> "$PROFILE_PATH/user.js"
    echo 'user_pref("network.http.referer.XOriginPolicy", 2);' >> "$PROFILE_PATH/user.js"
    echo -e "${GREEN}about:config settings applied.${NC}"
    echo "about:config privacy settings applied." >> "$LOG_FILE"
}

# Install hosts file for ad-blocking
install_hosts_file() {
    echo "Downloading and applying StevenBlack's hosts file..."
    sudo wget -q https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/hosts
    echo -e "${GREEN}Hosts file applied to block ads and trackers.${NC}"
    echo "StevenBlack's hosts file applied." >> "$LOG_FILE"
}

# Set up DNS over HTTPS
setup_dns_over_https() {
    echo "Setting up DNS over HTTPS using Cloudflare..."
    sudo sh -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'
    echo -e "${GREEN}DNS over HTTPS is now configured to use Cloudflare.${NC}"
    echo "DNS over HTTPS set to Cloudflare." >> "$LOG_FILE"
}

# Install Tor Browser for privacy
install_tor() {
    echo "Installing Tor Browser..."
    sudo apt update && sudo apt install torbrowser-launcher -y
    echo -e "${GREEN}Tor Browser installed.${NC}"
    echo "Tor Browser installed." >> "$LOG_FILE"
}

# Menu to guide user
display_menu() {
    echo -e "${GREEN}Linux Firefox Privacy & Security Setup Script${NC}"
    echo "1. Apply Arkenfox user.js"
    echo "2. Install privacy extensions"
    echo "3. Apply about:config changes"
    echo "4. Install hosts file (ad and tracker blocker)"
    echo "5. Set up DNS over HTTPS (Cloudflare)"
    echo "6. Install Tor Browser"
    echo "7. Run full setup (All in one)"
    echo "8. Exit"
    read -p "Choose an option: " choice
}

# Main script
main() {
    # Ensure the system is up to date
    update_system

    get_firefox_profile

    while true; do
        display_menu
        case $choice in
            1) install_arkenfox_userjs ;;
            2) install_extensions ;;
            3) apply_about_config ;;
            4) install_hosts_file ;;
            5) setup_dns_over_https ;;
            6) install_tor ;;
            7) 
               install_arkenfox_userjs
               install_extensions
               apply_about_config
               install_hosts_file
               setup_dns_over_https
               install_tor
               ;;
            8) exit ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Run the script
main
