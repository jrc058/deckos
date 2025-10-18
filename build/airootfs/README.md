# DeckOS airootfs Structure

This directory contains files that will be copied to the root filesystem of the DeckOS ISO.

## Directory Structure

```
airootfs/
├── etc/
│   ├── skel/                          # Default user home directory files
│   │   ├── .config/
│   │   │   ├── alacritty/            # Terminal config
│   │   │   └── sway/                 # Developer mode WM config
│   │   └── .zshrc                    # Shell configuration
│   ├── sddm.conf.d/                  # Display manager config
│   ├── systemd/system/               # System services
│   ├── NetworkManager/conf.d/        # Network configuration
│   ├── sysctl.d/                     # Kernel parameters
│   ├── pacman.d/hooks/               # Package manager hooks
│   ├── profile.d/                    # Shell profile scripts
│   ├── environment                   # Global environment variables
│   └── modprobe.d/                   # Kernel module configuration
└── usr/
    └── local/
        └── bin/                       # Custom DeckOS scripts
```

## Configuration Files

### User Configurations (etc/skel/)
- **alacritty.toml**: Terminal emulator optimized for handheld screens
- **sway/config**: Developer mode window manager (Wayland)
- **.zshrc**: Shell with handy aliases and DeckOS helpers

### System Configurations (etc/)
- **sddm.conf.d/deckos.conf**: Display manager for Plasma Mobile
- **NetworkManager/conf.d/deckos.conf**: WiFi optimizations using iwd backend
- **sysctl.d/99-deckos.conf**: Kernel tuning for gaming and responsiveness
- **environment**: Wayland and gaming environment variables
- **modprobe.d/deckos.conf**: GPU power management

### Services (etc/systemd/system/)
- **deckos-power.service**: Power management setup on boot

### Scripts (usr/local/bin/)
- **deckos-power-setup**: Configures TLP and power management

## Customization

To add your own configurations:

1. Place files in the appropriate directory under `airootfs/`
2. Files in `etc/skel/` will be copied to new user home directories
3. Files in `etc/` will be system-wide configurations
4. Scripts in `usr/local/bin/` should be executable

## Build Process

When you run `./mkdeckos.sh`, these files are:
1. Copied to the ISO filesystem
2. Applied during system installation
3. Available on first boot

## Testing

After building, test in VM with:
```bash
./test-vm.sh
```

Check that:
- Sway launches with correct config
- Terminal uses Hack font
- Power management is active
- Network connects properly
