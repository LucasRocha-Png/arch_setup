#!/bin/bash

packages=(
nvidia
nvidia-utils
nvidia-settings
)

../utils/pacman_ip.sh "${packages[@]}"
