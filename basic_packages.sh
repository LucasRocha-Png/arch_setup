#!/bin/bash

echo "Installing basic packages"

terminal_packages=(
vi
vim
neovim
nano
sudo
code
git
base-devel
fastfetch
htop
unzip
wget
)

gui_packages=(
firefox
kitty
)

./utils/install_packages.sh "${terminal_packages[@]}"
./utils/install_packages.sh "${gui_packages[@]}"
