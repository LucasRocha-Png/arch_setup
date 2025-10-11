#!/bin/bash

echo "Installing audio drivers."

packages=(
pipewire
wireplumber
pipewire-audio
pipewire-pulse
)

./utils/install_packages.sh "${packages[@]}"

systemctl --user enable --now pipewire pipewire-pulse wireplumber