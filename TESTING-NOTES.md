# DeckOS Testing Notes

## Test Session 1 - 2025-10-18

### What Worked ✅
- ISO builds successfully (843 packages)
- Boots in QEMU
- Custom DeckOS branding present (`/etc/os-release`)
- Custom scripts copied to `/usr/local/bin/`
- Configuration files in `/etc/skel/`
- Library scripts in `/usr/local/lib/deckos/`
- Script permissions set correctly in profiledef.sh
- arch-install-scripts present (pacstrap, genfstab, arch-chroot)

### Issues Found 🔧
1. **Missing Package: dialog**
   - First-boot wizard requires `dialog` for TUI
   - Added to packages.x86_64
   - Also added `arch-install-scripts` explicitly

### Network Status
- QEMU test-vm.sh already has networking configured
- Uses `-net nic -net user` for user-mode networking
- Should work in next test

### Next Test Goals
1. Verify dialog is installed
2. Run first-boot wizard
3. Test disk detection and partitioning
4. See how far installer gets with network access
5. Test package installation from repos

### Build Changes Made
- Added `dialog` to packages.x86_64
- Added `arch-install-scripts` to packages.x86_64 (explicit)
- No other changes needed - permissions already correct

### Rebuild Command
```bash
cd "Custom Distro Project/deckos-git/deckos/build"
sudo ./mkdeckos.sh
```

### Test Command
```bash
cd "Custom Distro Project/deckos-git/deckos/build"
bash test-vm.sh
```

### In VM Test Commands
```bash
# Verify dialog installed
which dialog

# Check network
ping -c 3 archlinux.org

# Run installer
sudo /usr/local/bin/deckos-firstboot
```
