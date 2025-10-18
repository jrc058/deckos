#!/bin/bash
# Hardware detection module

detect_hardware() {
    echo "Detecting hardware..."
    
    # Detect screen size
    SCREEN_SIZE=$(xrandr 2>/dev/null | grep -oP '\d+x\d+' | head -1 | cut -d'x' -f1)
    
    # Detect touchscreen
    HAS_TOUCH=$(xinput list 2>/dev/null | grep -i touch | wc -l)
    
    # Detect microphone
    HAS_MIC=$(arecord -l 2>/dev/null | grep -i card | wc -l)
    
    # Detect RAM
    TOTAL_RAM=$(free -g | awk '/^Mem:/{print $2}')
    
    # Detect CPU
    CPU_CORES=$(nproc)
    
    # Save to config
    mkdir -p /etc/deckos
    cat > /etc/deckos/hardware.conf << EOF
SCREEN_SIZE=$SCREEN_SIZE
HAS_TOUCH=$HAS_TOUCH
HAS_MIC=$HAS_MIC
TOTAL_RAM=$TOTAL_RAM
CPU_CORES=$CPU_CORES
EOF
    
    # Show detection results
    dialog --title "Hardware Detected" \
           --msgbox "Screen: ${SCREEN_SIZE}px\n\
Touchscreen: $([ $HAS_TOUCH -gt 0 ] && echo "Yes" || echo "No")\n\
Microphone: $([ $HAS_MIC -gt 0 ] && echo "Yes" || echo "No")\n\
RAM: ${TOTAL_RAM}GB\n\
CPU Cores: $CPU_CORES" 12 50
}
