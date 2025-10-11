#!/bin/bash

echo "Installing networking and bluetooth drivers."

pacman -S networkmanager dhcpcd iwd bluez bluez-utils blueman

systemctl enable --now bluetooth
systemctl enable --now NetworkManager
systemctl enable --now iwd


# iwd - WiFI
# bluez - Bluetooth
# dhcpcd -  Used to assingning IP addresses to a device on a network.

