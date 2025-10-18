@echo off
echo Fixing package list...
cd /d "%~dp0"

git add .
git commit -m "Fix: Remove non-existent packages

- Remove systemd-boot (included in systemd)
- Replace wireless-tools with iw (modern replacement)"

git push origin main

echo.
echo Fixed! Pull and rebuild:
echo   git pull
echo   sudo ./mkdeckos.sh
pause
