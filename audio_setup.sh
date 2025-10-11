#!/bin/bash

echo "Installing audio drivers."

pacman -S pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa pipewire-media-session

systemctl --user enable --now pipewire pipewire-pulse wireplumber
