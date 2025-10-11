#!/bin/bash

echo "Installing basic packages"

pacman -S vi vim nano sudo iwd dhcpcd git base-devel networkmanager fastfetch

# iwd - WIFI
# dhcpcd - DHCP client
# base-devel - packages like 'gcc'
