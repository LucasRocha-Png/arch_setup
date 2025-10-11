#!/bin/bash

echo "Installing yay."

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
