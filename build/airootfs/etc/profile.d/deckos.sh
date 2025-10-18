#!/bin/sh
# DeckOS Profile Configuration

# Add user scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

# DeckOS version info
export DECKOS_VERSION="0.1.0-alpha"
export DECKOS_CODENAME="Foundation"

# Helper function to check mode
deckos_mode() {
    if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
        echo "consumer"
    elif [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
        echo "developer"
    else
        echo "unknown"
    fi
}

# Welcome message
if [ -t 0 ]; then
    echo "Welcome to DeckOS $DECKOS_VERSION ($DECKOS_CODENAME)"
    echo "Mode: $(deckos_mode)"
fi
