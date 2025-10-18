@echo off
REM Commit test fixes from first VM test

cd /d "%~dp0"

echo Adding test fixes...
git add build/packages.x86_64
git add TESTING-NOTES.md

echo.
echo Committing...
git commit -m "test: Add dialog package and testing notes

- Added dialog package for first-boot wizard TUI
- Added arch-install-scripts explicitly to packages
- Created TESTING-NOTES.md to track test sessions
- First VM test successful: ISO boots, scripts present
- Ready for installer testing with dialog support"

echo.
echo Commit complete!
echo.
echo Next steps:
echo 1. Push to git (if using remote): git push
echo 2. On Arch machine: git pull
echo 3. On Arch machine: cd build && sudo ./mkdeckos.sh
echo 4. On Arch machine: bash test-vm.sh
pause
