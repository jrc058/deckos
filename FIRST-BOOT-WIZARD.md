# DeckOS First Boot Setup Wizard

**Interactive setup experience for new installations**

## Overview

The first-boot wizard guides users through essential configuration in under 2 minutes:
- Hardware detection
- Mode selection (Consumer/Developer)
- User account creation
- Network setup
- AI configuration
- Voice control setup

## Architecture

### Main Script
- **Location**: `/usr/local/bin/deckos-firstboot`
- **Purpose**: Orchestrates the setup flow
- **Runs**: Once on first boot via systemd service

### Setup Modules
Located in `/usr/local/lib/deckos/`:

1. **setup-welcome.sh** - Welcome screen and skip option
2. **setup-hardware.sh** - Auto-detect hardware capabilities
3. **setup-mode.sh** - Choose Consumer or Developer mode
4. **setup-user.sh** - Create user account with validation
5. **setup-network.sh** - WiFi configuration (optional)
6. **setup-ai.sh** - AI processing mode and voice control
7. **setup-finalize.sh** - Apply settings and configure services

### Systemd Service
- **Location**: `/etc/systemd/system/deckos-firstboot.service`
- **Trigger**: Runs once if `/etc/deckos/.setup-complete` doesn't exist
- **Type**: oneshot with TTY access

## Setup Flow

```
┌─────────────────────────────────────┐
│         Welcome Screen              │
│  (5 sec auto-advance or skip)       │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│      Hardware Detection             │
│  • Screen size                      │
│  • Touchscreen                      │
│  • Microphone                       │
│  • RAM/CPU                          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│       Mode Selection                │
│  Consumer vs Developer              │
│  (Smart default based on hardware)  │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│      User Account Creation          │
│  • Username validation              │
│  • Password (min 8 chars)           │
│  • Confirmation                     │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│       Network Setup                 │
│  WiFi configuration (optional)      │
│  Uses nmtui for connection          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│      AI Configuration               │
│  • Local / Hybrid / Cloud           │
│  • Voice control (if mic detected)  │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│       Finalization                  │
│  • Apply all settings               │
│  • Configure services               │
│  • Enable mode-specific features    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│      Completion & Reboot            │
│  Mark setup complete                │
│  Show quick tips                    │
└─────────────────────────────────────┘
```

## Smart Defaults

### Hardware-Based Defaults

**Touchscreen Detected:**
- Mode: Consumer
- Display scaling: Based on screen size
- Touch gestures: Enabled

**No Touchscreen:**
- Mode: Developer
- Keyboard shortcuts: Emphasized
- Terminal-first workflow

**Microphone Detected:**
- Voice control: Offered (user choice)
- Wake word: "Hey Computer"
- Battery impact warning shown

**RAM-Based AI Defaults:**
- ≥4GB: Hybrid (Local + Cloud)
- <4GB: Cloud only
- User can override

### Skip Setup Defaults

If user skips setup entirely:
- Mode: Auto-detected from hardware
- Voice: Disabled
- Display: Auto-scaled
- AI: Hybrid (if RAM allows)
- Privacy: Maximum
- Network: Not configured
- User: Must be created manually

## Configuration Files

### Generated Configs

**/etc/deckos/setup.conf**
```bash
MODE=developer
USERNAME=john
AI_MODE=hybrid
VOICE_ENABLED=true
DISPLAY_SCALE=1.25
NETWORK_CONFIGURED=true
```

**/etc/deckos/hardware.conf**
```bash
SCREEN_SIZE=1280
HAS_TOUCH=0
HAS_MIC=1
TOTAL_RAM=8
CPU_CORES=4
```

**/etc/deckos/.setup-complete**
- Empty file marking setup completion
- Prevents wizard from running again

## Post-Setup Reconfiguration

Users can reconfigure anytime with:
```bash
deckos-setup
```

This launches a menu to change:
- Mode (Consumer/Developer)
- Voice control
- AI configuration
- Display settings
- Network settings

## Mode Configuration

### Consumer Mode
**Enables:**
- SDDM display manager
- Plasma Mobile session
- Auto-login (optional)
- Touch-optimized UI
- Media apps

**Services:**
```bash
systemctl enable sddm.service
```

### Developer Mode
**Enables:**
- Sway compositor
- Terminal auto-start
- Keyboard-driven workflow
- Development tools

**Configuration:**
- `.xinitrc` with `exec sway`
- Sway config in `~/.config/sway/`

## AI Configuration

### Local Mode
- All processing on-device
- No internet required
- 2-4GB RAM needed
- Slower but private

**Services:**
```bash
systemctl enable deckos-ai-local.service
```

### Hybrid Mode (Recommended)
- Local for quick tasks
- Cloud for complex queries
- Best performance
- Balanced privacy

**Services:**
```bash
systemctl enable deckos-ai-hybrid.service
```

### Cloud Mode
- All processing remote
- Fastest responses
- Internet required
- Minimal local resources

**Configuration:**
```bash
echo "AI_ENDPOINT=cloud" >> /etc/deckos/ai.conf
```

## Voice Control

### Setup
If microphone detected and user enables:
```bash
systemctl enable deckos-voice.service
systemctl start deckos-voice.service
```

### Wake Word
- Default: "Hey Computer"
- Configurable in settings
- Always listening (low power)

### Battery Impact
- ~2-3% per hour
- Shown during setup
- Can be disabled anytime

## Testing

### Manual Testing
```bash
# Run wizard manually
sudo /usr/local/bin/deckos-firstboot

# Test individual modules
source /usr/local/lib/deckos/setup-hardware.sh
detect_hardware

# Check configuration
cat /etc/deckos/setup.conf
cat /etc/deckos/hardware.conf
```

### Reset Setup
```bash
# Remove completion marker
sudo rm /etc/deckos/.setup-complete

# Clear configs
sudo rm /etc/deckos/setup.conf
sudo rm /etc/deckos/hardware.conf

# Run wizard again
sudo systemctl start deckos-firstboot.service
```

## Troubleshooting

### Wizard Doesn't Start
```bash
# Check service status
systemctl status deckos-firstboot.service

# Check if already completed
ls -la /etc/deckos/.setup-complete

# Run manually
sudo /usr/local/bin/deckos-firstboot
```

### Dialog Not Found
```bash
# Install dialog package
sudo pacman -S dialog
```

### User Creation Fails
```bash
# Check if user already exists
id username

# Remove existing user
sudo userdel -r username
```

### Network Setup Fails
```bash
# Check NetworkManager
systemctl status NetworkManager

# Use nmtui directly
nmtui
```

## Future Enhancements

### Planned Features
- [ ] Timezone auto-detection
- [ ] Language selection
- [ ] Keyboard layout detection
- [ ] Bluetooth device pairing
- [ ] Cloud account sync (optional)
- [ ] Tutorial after setup
- [ ] Hardware-specific optimizations
- [ ] Gaming controller setup

### UI Improvements
- [ ] Progress indicators
- [ ] Better error messages
- [ ] Undo/back navigation
- [ ] Preview mode changes
- [ ] Accessibility options

---

**Status**: Phase 2 Complete ✅  
**Next**: AI Stack Integration  
**Version**: 0.1.0-alpha
