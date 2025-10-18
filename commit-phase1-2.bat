@echo off
echo ========================================
echo DeckOS Phase 1 + 2 Commit Script
echo ========================================
echo.

cd /d "%~dp0"

echo Configuring git...
git config user.name "John Cravey"
git config user.email "jrc058@shsu.edu"
git config core.autocrlf true
echo.

echo Checking status...
git status
echo.

echo Staging all files...
git add .
echo.

echo Creating commit...
git commit -m "Phase 1 + 2: Complete foundation and AI integration

Phase 1 - Foundation:
- Complete package list (15GB standard config)
- Custom configurations (terminal, shell, WM, power, network)
- Build system (mkdeckos.sh, test-vm.sh, profiledef.sh)
- System optimizations (kernel tuning, GPU power management)

Phase 2 - First Boot Wizard:
- Interactive setup wizard with hardware detection
- Mode selection (Consumer/Developer)
- User account creation with validation
- Network setup (WiFi)
- AI configuration (Local/Hybrid/Cloud)
- Voice control setup (if mic detected)
- Smart defaults based on hardware
- Post-setup reconfiguration tool

Phase 2 - AI Integration (70%):
- AI Manager (power-aware orchestrator)
- Model Installer (download system with resume)
- Query Router (smart local/cloud routing)
- Systemd services (ollama, whisper, tts, wake-word)
- Power-aware service management
- First-boot integration

Documentation:
- CONFIGURATION.md - System configuration overview
- FIRST-BOOT-WIZARD.md - Setup wizard documentation
- AI-INTEGRATION.md - AI stack documentation
- STATUS.md - Project status and progress

Ready for first build and testing!"

echo.
echo Pushing to GitHub...
git push origin main
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo SUCCESS! All changes committed and pushed
    echo ========================================
    echo.
    echo Next steps on your Arch PC:
    echo   cd ~/
    echo   git clone https://github.com/jrc058/deckos.git
    echo   cd deckos/Custom\ Distro\ Project/deckos-git/deckos/build/
    echo   sudo ./mkdeckos.sh
    echo.
) else (
    echo ========================================
    echo ERROR: Push failed
    echo ========================================
    echo Check your GitHub credentials and try again
    echo.
)

pause
