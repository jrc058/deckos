#!/bin/bash
# Finalization module

finalize_setup() {
    source /etc/deckos/setup.conf
    source /etc/deckos/hardware.conf
    
    # Progress dialog
    (
        echo "10" ; echo "# Creating user account..."
        sleep 1
        
        echo "30" ; echo "# Configuring display..."
        configure_display
        sleep 1
        
        echo "50" ; echo "# Setting up AI models..."
        configure_ai
        sleep 2
        
        echo "70" ; echo "# Applying mode settings..."
        configure_mode
        sleep 1
        
        echo "90" ; echo "# Finalizing configuration..."
        apply_final_settings
        sleep 1
        
        echo "100" ; echo "# Setup complete!"
    ) | dialog --title "Setting Up Your System" \
               --gauge "Please wait..." 10 60 0
    
    # Show completion message
    dialog --title "You're All Set!" \
           --msgbox "Quick Tips:\n\n\
• Swipe up for app launcher\n\
• $([ "$VOICE_ENABLED" = "true" ] && echo 'Say "Hey Computer" for voice' || echo 'Voice control disabled')\n\
• Hold power to switch modes\n\
• Settings in quick panel\n\n\
Press OK to start using your system!" 15 60
}

configure_display() {
    # Set display scaling based on screen size
    if [ $SCREEN_SIZE -lt 1000 ]; then
        SCALE="1.5"
    elif [ $SCREEN_SIZE -lt 1500 ]; then
        SCALE="1.25"
    else
        SCALE="1.0"
    fi
    
    echo "DISPLAY_SCALE=$SCALE" >> /etc/deckos/setup.conf
}

configure_ai() {
    # Create AI configuration
    mkdir -p /etc/deckos
    cat > /etc/deckos/ai.conf << EOF
{
  "ai_mode": "$AI_MODE",
  "voice_enabled": $VOICE_ENABLED,
  "power_aware": true,
  "home_server": null,
  "cloud_provider": null
}
EOF
    
    # Enable AI manager service
    systemctl enable deckos-ai-manager.service
    
    # Offer to download models now or later
    dialog --title "Download AI Models?" \
           --yesno "Download AI models now?\n\n\
This will download ~2-10GB depending on configuration.\n\
You can also download later with: deckos-ai-install\n\n\
Download now?" 12 60
    
    if [ $? -eq 0 ]; then
        # Determine tier based on AI mode
        case $AI_MODE in
            local)
                TIER="standard"
                ;;
            hybrid)
                TIER="standard"
                ;;
            cloud)
                TIER="minimal"
                ;;
        esac
        
        # Download in background (will continue after reboot if needed)
        /usr/local/bin/deckos-ai-install $TIER &
    fi
    
    if [ "$VOICE_ENABLED" = "true" ]; then
        systemctl enable deckos-wake-word.service
        systemctl enable deckos-whisper.service
        systemctl enable deckos-tts.service
    fi
}

configure_mode() {
    case $MODE in
        consumer)
            # Enable Plasma Mobile
            systemctl enable sddm.service
            echo "Session=plasma-mobile" >> /etc/sddm.conf.d/autologin.conf
            echo "User=$USERNAME" >> /etc/sddm.conf.d/autologin.conf
            ;;
        developer)
            # Enable Sway auto-start
            mkdir -p /home/$USERNAME/.config/autostart
            echo "exec sway" > /home/$USERNAME/.xinitrc
            chown -R $USERNAME:$USERNAME /home/$USERNAME
            ;;
    esac
}

apply_final_settings() {
    # Enable essential services
    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable deckos-power.service
    
    # Set timezone (can be improved with detection)
    timedatectl set-timezone America/Chicago
    
    # Enable NTP
    timedatectl set-ntp true
    
    # Apply power settings
    /usr/local/bin/deckos-power-setup
}
