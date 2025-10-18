#!/bin/bash
# Welcome screen module

setup_welcome() {
    dialog --title "Welcome to DeckOS" \
           --msgbox "Welcome to DeckOS - Your AI-Native Handheld OS\n\n\
Touch-First • AI-Native • Fast\n\n\
This wizard will help you set up your system in under 2 minutes.\n\n\
Press OK to continue or ESC to use defaults." 12 60
    
    if [ $? -ne 0 ]; then
        # User pressed ESC - use defaults
        use_defaults
        exit 0
    fi
}

use_defaults() {
    dialog --title "Use Default Settings?" \
           --yesno "Configure with smart defaults?\n\n\
• Mode: Auto-detected\n\
• Voice: Disabled\n\
• Display: Auto-scaled\n\
• AI: Local + Cloud\n\
• Privacy: Maximum\n\n\
You can change everything later in Settings." 15 60
    
    if [ $? -eq 0 ]; then
        apply_defaults
        touch "$SETUP_COMPLETE"
        reboot
    fi
}

apply_defaults() {
    echo "Applying default configuration..."
    # Will be implemented in finalize module
}
