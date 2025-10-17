#!/bin/bash
# DeckOS Build Script
# Builds bootable ISO from archiso profile

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${SCRIPT_DIR}/work"
OUT_DIR="${SCRIPT_DIR}/out"

echo "╔═══════════════════════════════════════╗"
echo "║       Building DeckOS ISO             ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "Build directory: ${SCRIPT_DIR}"
echo "Work directory: ${WORK_DIR}"
echo "Output directory: ${OUT_DIR}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Check if mkarchiso is installed
if ! command -v mkarchiso &> /dev/null; then
    echo "Error: mkarchiso not found. Install with: pacman -S archiso"
    exit 1
fi

# Clean previous build
if [ -d "${WORK_DIR}" ]; then
    echo "Cleaning previous build..."
    rm -rf "${WORK_DIR}"
fi

if [ -d "${OUT_DIR}" ]; then
    echo "Cleaning previous output..."
    rm -rf "${OUT_DIR}"
fi

mkdir -p "${WORK_DIR}" "${OUT_DIR}"

# Build ISO
echo ""
echo "Building ISO (this will take 10-30 minutes)..."
echo ""

mkarchiso -v -w "${WORK_DIR}" -o "${OUT_DIR}" "${SCRIPT_DIR}"

# Success
echo ""
echo "╔═══════════════════════════════════════╗"
echo "║       Build Complete!                 ║"
echo "╚═══════════════════════════════════════╝"
echo ""

ISO_FILE=$(ls -t "${OUT_DIR}"/*.iso 2>/dev/null | head -1)
if [ -n "$ISO_FILE" ]; then
    ISO_SIZE=$(du -h "$ISO_FILE" | cut -f1)
    echo "ISO: $ISO_FILE"
    echo "Size: $ISO_SIZE"
    echo ""
    echo "Test with: ./test-vm.sh"
    echo "Write to USB: sudo dd if=$ISO_FILE of=/dev/sdX bs=4M status=progress"
else
    echo "Warning: ISO file not found in output directory"
fi

echo ""
