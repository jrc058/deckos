# DeckOS Configuration Overview

**Phase 1 Complete: Foundation + Custom Configurations**

## What We Built

### 1. Package Selection ✅
- **Location**: `build/packages.x86_64`
- **Size**: ~15GB (Standard Configuration)
- **Includes**:
  - Base system with development tools
  - Full networking stack (WiFi, Bluetooth, SSH)
  - Wayland display stack with GPU drivers
  - PipeWire audio system
  - Developer Mode (Sway + terminal tools)
  - Consumer Mode (Plasma Desktop + KDE apps)
  - Security tools (2FA, encryption)
  - System services (power, time, hardware)

### 2. Custom Configurations ✅
- **Location**: `build/airootfs/`
- **Purpose**: Optimize for handheld/cyberdeck use

#### User Configurations
**Terminal (Alacritty)**
- Optimized font size for handheld screens
- Dark theme with good contrast
- Keyboard shortcuts for touch-friendly use

**Shell (ZSH)**
- Clean, minimal prompt for small screens
- Handy aliases (`gamemode`, `devmode`, `battery`)
- Syntax highlighting and auto-suggestions
- Command history with smart deduplication

**Window Manager (Sway)**
- Touch-friendly input configuration
- Steam Deck button mappings
- Efficient workspace management
- Status bar with essential info

#### System Configurations
**Display Manager (SDDM)**
- Wayland-first configuration
- Auto-login support (disabled by default)
- Breeze theme

**Network (NetworkManager)**
- iwd backend for better WiFi performance
- Power-saving enabled on battery
- Auto-connect to known networks
- Wake-on-WLAN for updates

**Power Management (TLP)**
- CPU governor switching (performance/powersave)
- Battery charge thresholds (75-80%)
- USB autosuspend with smart exclusions
- WiFi power saving on battery
- Platform profiles for AC/battery

**Kernel Tuning (sysctl)**
- Increased file watchers for development
- Low swappiness for better responsiveness
- BBR congestion control for networking
- Gaming optimizations (vm.max_map_count)

**Environment Variables**
- Wayland-first for all applications
- Gaming optimizations (MangoHUD, DXVK)
- Neovim as default editor

**GPU Power Management**
- Intel: GuC firmware, framebuffer compression
- AMD: Full feature mask enabled
- Bluetooth: Autosuspend enabled

## File Structure

```
deckos/
├── build/
│   ├── mkdeckos.sh              # Build script
│   ├── test-vm.sh               # VM testing script
│   ├── packages.x86_64          # Package list
│   ├── pacman.conf              # Package manager config
│   ├── profiledef.sh            # ISO profile definition
│   └── airootfs/                # Files copied to ISO
│       ├── etc/
│       │   ├── skel/            # User home defaults
│       │   │   ├── .config/
│       │   │   │   ├── alacritty/
│       │   │   │   └── sway/
│       │   │   └── .zshrc
│       │   ├── sddm.conf.d/
│       │   ├── systemd/system/
│       │   ├── NetworkManager/conf.d/
│       │   ├── sysctl.d/
│       │   ├── pacman.d/hooks/
│       │   ├── profile.d/
│       │   ├── environment
│       │   └── modprobe.d/
│       └── usr/local/bin/
└── CONFIGURATION.md             # This file
```

## Configuration Philosophy

### Handheld-First Design
- **Touch-friendly**: Large tap targets, gesture support
- **Battery-aware**: Aggressive power management
- **Screen-optimized**: Readable fonts, efficient layouts
- **Performance**: Low-latency audio, fast WiFi, responsive UI

### Dual-Mode Architecture
**Developer Mode (Sway)**
- Keyboard-driven workflow
- Minimal resource usage
- Terminal-centric
- Maximum control

**Consumer Mode (Plasma)**
- Touch-friendly interface
- Visual app launcher
- Media consumption
- Gaming focus

### Power Management Strategy
**On AC Power**
- Performance CPU governor
- CPU boost enabled
- Full GPU performance
- WiFi power save off

**On Battery**
- Powersave CPU governor
- CPU boost disabled
- Balanced GPU performance
- WiFi power save on
- USB autosuspend active

## Next Steps

### Phase 2: First Boot Experience
- [ ] Create first-boot setup wizard
- [ ] User account creation
- [ ] WiFi setup
- [ ] AI stack installation (optional)
- [ ] Mode selection (Developer/Consumer)
- [ ] Auto-login configuration

### Phase 3: AI Integration
- [ ] Ollama installation script
- [ ] Model download manager
- [ ] Voice control setup
- [ ] Power-aware AI scheduling

### Phase 4: Testing & Refinement
- [ ] Build ISO and test in VM
- [ ] Test on real hardware (Steam Deck)
- [ ] Performance benchmarking
- [ ] Battery life testing
- [ ] User experience refinement

## Testing Checklist

When you build and test:

**Boot & Display**
- [ ] ISO boots in UEFI mode
- [ ] Sway launches correctly
- [ ] Display resolution correct
- [ ] Touch input works

**Network**
- [ ] WiFi connects
- [ ] Bluetooth pairs
- [ ] SSH accessible

**Power**
- [ ] TLP service running
- [ ] Battery info accessible
- [ ] Suspend/resume works
- [ ] Power button responds

**User Experience**
- [ ] Terminal readable
- [ ] Shell aliases work
- [ ] File manager functional
- [ ] Applications launch

**Performance**
- [ ] Smooth UI
- [ ] Low latency audio
- [ ] Fast package updates
- [ ] Responsive input

## Build Commands

```bash
# Build the ISO
cd build
./mkdeckos.sh

# Test in VM
./test-vm.sh

# Clean build artifacts
sudo rm -rf work/ out/
```

## Customization Guide

### Adding Your Own Configs
1. Place files in `airootfs/` matching target location
2. Update `profiledef.sh` if permissions needed
3. Rebuild ISO

### Modifying Package List
1. Edit `packages.x86_64`
2. One package per line
3. Comments with `#`
4. Rebuild ISO

### Changing Power Settings
1. Edit `airootfs/usr/local/bin/deckos-power-setup`
2. Modify TLP configuration values
3. Rebuild ISO

---

**Status**: Phase 1 Complete ✅  
**Next**: First Boot Setup Wizard  
**Version**: 0.1.0-alpha (Foundation)
