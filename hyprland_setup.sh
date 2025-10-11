#!/bin/bash

echo "Installing hyperland."

packages=(
    hyprland
    hyprlock
    hypridle
    hyprpicker
    hyprpaper
    xdg-desktop-portal-hyprland
    waybar
    dolphin
    qt5ct
    qt6ct
    wl-clipboard
    vlc
)



./utils/install_packages.sh "${packages[@]}"
