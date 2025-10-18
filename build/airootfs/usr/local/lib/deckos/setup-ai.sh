#!/bin/bash
# AI configuration module

setup_ai() {
    source /etc/deckos/hardware.conf
    
    # Smart default based on RAM
    if [ $TOTAL_RAM -ge 4 ]; then
        DEFAULT_AI="hybrid"
    else
        DEFAULT_AI="cloud"
    fi
    
    dialog --title "AI Assistant Setup" \
           --menu "Choose AI processing mode:\n" 15 60 3 \
           "local" "Local only (Private, 2-4GB RAM)" \
           "hybrid" "Local + Cloud (Balanced, recommended)" \
           "cloud" "Cloud only (Fast, requires internet)" \
           2> /tmp/ai_choice
    
    if [ $? -eq 0 ]; then
        AI_MODE=$(cat /tmp/ai_choice)
    else
        AI_MODE=$DEFAULT_AI
    fi
    
    echo "AI_MODE=$AI_MODE" >> /etc/deckos/setup.conf
    
    # Ask about voice control if mic detected
    if [ $HAS_MIC -gt 0 ]; then
        dialog --title "Voice Control" \
               --yesno "Enable voice control?\n\n\
Microphone detected. You can control your system with voice commands.\n\n\
Battery impact: ~2-3% per hour\n\n\
Enable voice control?" 12 60
        
        if [ $? -eq 0 ]; then
            echo "VOICE_ENABLED=true" >> /etc/deckos/setup.conf
        else
            echo "VOICE_ENABLED=false" >> /etc/deckos/setup.conf
        fi
    else
        echo "VOICE_ENABLED=false" >> /etc/deckos/setup.conf
    fi
    
    rm -f /tmp/ai_choice
}
