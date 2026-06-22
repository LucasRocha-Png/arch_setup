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
usbutils
udisks2
udiskie
dosfstools
ntfs-3g 
exfatprogs
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
freerdp # Windows <-> Linux
remmina # Windows <-> Linux
usb_modeswitch
)
../utils/pacman_ip.sh "${packages[@]}"

yay_packages=(
    pavucontrol-gtk3
    aic8800d80-wifi-bt-git-dkms
)

../utils/yay_ip.sh "${yay_packages[@]}"

sudo systemctl enable --now bluetooth NetworkManager iwd dhcpcd cups.service
echo "Run hp-plugin to configure your printer"

echo "Check your lsusb"
echo "ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1111", ATTRS{idProduct}=="1111", RUN+="/usr/bin/usb_modeswitch -v 1111 -p 1111 -M '555342438765432100000000000010fd0000000000000000000000000000f3' -2 '555342438765432100000000000010fd0000000000000000000000000000f2'"" > /etc/udev/rules.d/40-aic8800.rules 
sudo udevadm control --reload-rules && sudo udevadm trigger
echo "ip link"
sudo ip link set wlan0 up
