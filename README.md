# DeckOS

Touch-first, AI-native Linux distribution for tablets and cyberdecks.

## Features

- **Dual-Mode**: Consumer (Plasma Mobile) and Developer (Sway)
- **Voice Control**: "Hey Archie" wake word with local AI
- **AI-Native**: Local LLM, STT, TTS built-in
- **Privacy-First**: No telemetry, local processing
- **Touch-Optimized**: Designed for 5"-12" touchscreens
- **Hardware 2FA**: YubiKey and FIDO2 support

## Status

🚧 **In Development** - Phase 1: Foundation

Current version: 0.1.0-alpha

## Quick Start

### Build ISO

```bash
cd build
sudo ./mkdeckos.sh
```

### Test in VM

```bash
cd build
./test-vm.sh
```

### Write to USB

```bash
sudo dd if=build/out/deckos-*.iso of=/dev/sdX bs=4M status=progress
```

## Documentation

- [Build Guide](docs/BUILD.md)
- [Installation Guide](docs/INSTALL.md)
- [Contributing](docs/CONTRIBUTING.md)

## Project Structure

```
deckos/
├── build/          # Build system (archiso)
├── docs/           # Documentation
├── scripts/        # Utility scripts
└── configs/        # Configuration files
```

## Requirements

- Arch Linux (for building)
- 50GB free disk space
- 8GB+ RAM
- archiso package

## License

GPL-3.0

## Links

- Website: https://deckos.org (coming soon)
- GitHub: https://github.com/[username]/deckos
- Documentation: https://docs.deckos.org (coming soon)

---

*Building the future of touch-first, AI-native computing.*
