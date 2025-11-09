#!/bin/bash

packages=(
amd-ucode
xf86-video-amdgpu
mesa
)

../utils/pacman_ip.sh "${packages[@]}"
