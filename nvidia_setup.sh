#!/bin/bash

packages=(
nvidia
nvidia-utils
nvidia-settings
)

./utils/install_packages.sh "${packages[@]}"
