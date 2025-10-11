#!/bin/bash

echo "Installing networking and bluetooth drivers."

packages=(
networkmanager
dhcpcd
iwd
bluez
bluez-utils
blueman
)

./utils/install_packages.sh "${packages[@]}"

systemctl enable --now bluetooth
systemctl enable --now NetworkManager
systemctl enable --now iwd


# iwd - WiFI
# bluez - Bluetooth
# dhcpcd -  Used to assingning IP addresses to a device on a network.