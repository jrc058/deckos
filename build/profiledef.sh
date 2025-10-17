#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="deckos"
iso_label="DECKOS_$(date +%Y%m)"
iso_publisher="DeckOS Project <https://deckos.org>"
iso_application="DeckOS Live/Install"
iso_version="0.1.0-alpha"
install_dir="deckos"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-x64.systemd-boot.esp'
           'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
)
