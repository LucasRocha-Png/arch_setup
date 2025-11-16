#!/bin/bash

echo "Installing networking and bluetooth drivers."

packages=(
networkmanager
network-manager-applet
dhcpcd
iwd
bluez
bluez-utils
blueman
pavucontrol
usbutils
gvfs-mtp 
gvfs-gphoto2 
gphoto2
proton-vpn-gtk-app
print-manager 
system-config-printer
hplip
cups
sane
simple-scan
polkit-gnome
android-tools
)


../utils/pacman_ip.sh "${packages[@]}"

sudo systemctl enable --now bluetooth NetworkManager iwd dhcpcd cups.service
echo "Run hp-plugin to configure your printer"