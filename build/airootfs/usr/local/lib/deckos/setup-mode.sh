#!/bin/bash
# Mode selection module

setup_mode() {
    source /etc/deckos/hardware.conf
    
    # Smart default based on hardware
    if [ $HAS_TOUCH -gt 0 ]; then
        DEFAULT_MODE="consumer"
    else
        DEFAULT_MODE="developer"
    fi
    
    dialog --title "Choose Your Primary Mode" \
           --menu "Select your preferred mode:\n\n\
You can switch modes anytime." 15 60 2 \
           "consumer" "Touch-first GUI, media, gaming" \
           "developer" "Terminal-first, coding, AI tools" \
           2> /tmp/mode_choice
    
    if [ $? -eq 0 ]; then
        MODE=$(cat /tmp/mode_choice)
    else
        MODE=$DEFAULT_MODE
    fi
    
    echo "MODE=$MODE" >> /etc/deckos/setup.conf
    
    rm -f /tmp/mode_choice
}
