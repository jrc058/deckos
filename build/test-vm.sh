#!/bin/bash
# DeckOS VM Test Script
# Tests ISO in QEMU virtual machine

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ISO=$(ls -t "${SCRIPT_DIR}/out/"*.iso 2>/dev/null | head -1)

if [ -z "$ISO" ]; then
    echo "Error: No ISO found. Build first with: sudo ./mkdeckos.sh"
    exit 1
fi

echo "Testing: $ISO"
echo ""
echo "QEMU Controls:"
echo "  Ctrl+Alt+F - Toggle fullscreen"
echo "  Ctrl+Alt+G - Release mouse"
echo "  Ctrl+C     - Quit"
echo ""

# Create test disk if doesn't exist
if [ ! -f "${SCRIPT_DIR}/test-disk.qcow2" ]; then
    echo "Creating test disk (32GB)..."
    qemu-img create -f qcow2 "${SCRIPT_DIR}/test-disk.qcow2" 32G
fi

# Check for OVMF (UEFI firmware)
if [ -f /usr/share/edk2-ovmf/x64/OVMF_CODE.fd ]; then
    OVMF_CODE="/usr/share/edk2-ovmf/x64/OVMF_CODE.fd"
elif [ -f /usr/share/ovmf/x64/OVMF_CODE.fd ]; then
    OVMF_CODE="/usr/share/ovmf/x64/OVMF_CODE.fd"
else
    echo "Warning: OVMF not found, trying without UEFI..."
    OVMF_CODE=""
fi

# Run QEMU with UEFI
if [ -n "$OVMF_CODE" ]; then
    echo "Using UEFI boot..."
    qemu-system-x86_64 \
        -enable-kvm \
        -m 4G \
        -smp 4 \
        -bios "$OVMF_CODE" \
        -cdrom "$ISO" \
        -boot d \
        -drive file="${SCRIPT_DIR}/test-disk.qcow2",format=qcow2 \
        -display gtk,gl=on \
        -device virtio-vga-gl \
        -device qemu-xhci \
        -device usb-tablet \
        -net nic -net user
else
    # Fallback to legacy BIOS
    qemu-system-x86_64 \
        -enable-kvm \
        -m 4G \
        -smp 4 \
        -cdrom "$ISO" \
        -boot d \
        -drive file="${SCRIPT_DIR}/test-disk.qcow2",format=qcow2 \
        -display gtk,gl=on \
        -device virtio-vga-gl \
        -device qemu-xhci \
        -device usb-tablet \
        -net nic -net user
fi
