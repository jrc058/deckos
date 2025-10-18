#!/bin/bash
# Network setup module

setup_network() {
    dialog --title "Network Setup" \
           --yesno "Would you like to connect to WiFi now?\n\n\
You can skip and connect later from quick settings." 10 50
    
    if [ $? -eq 0 ]; then
        # Launch nmtui for network configuration
        nmtui-connect
    else
        echo "NETWORK_CONFIGURED=false" >> /etc/deckos/setup.conf
    fi
}
