@echo off
echo Fixing bootloader configuration...
cd /d "%~dp0"

git add .
git commit -m "Fix: Add bootloader configuration

- Update profiledef.sh to use modern UEFI boot modes
- Add systemd-boot loader configuration
- Add boot entry for DeckOS
- Remove deprecated syslinux boot modes"

git push origin main

echo.
echo Fixed! Pull on your Arch PC and try building again:
echo   git pull
echo   sudo ./mkdeckos.sh
pause
