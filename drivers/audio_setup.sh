#!/bin/bash

echo "Installing audio drivers."

packages=(
pipewire
wireplumber
pipewire-audio
pipewire-pulse
easyeffects 
lsp-plugins
)

../utils/pacman_ip.sh "${packages[@]}"

systemctl --user enable --now pipewire pipewire-pulse wireplumber