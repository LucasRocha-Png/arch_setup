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
)

../utils/pacman_ip.sh "${packages[@]}"

systemctl enable --now bluetooth NetworkManager iwd dhcpcd


# iwd - WiFI
# bluez - Bluetooth
# dhcpcd -  Used to assingning IP addresses to a device on a network.
