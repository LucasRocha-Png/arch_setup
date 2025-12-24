#!/bin/bash

packages=(
nvidia-580xx-dkms 
nvidia-580xx-utils 
lib32-nvidia-580xx-utils
)

../utils/yay_ip.sh "${packages[@]}"
