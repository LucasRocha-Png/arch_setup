#!/bin/bash

packages=(
amd-ucode
xf86-video-amdgpu
mesa
)

./utils/install_packages.sh "${packages[@]}"
