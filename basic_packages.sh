#!/bin/bash

echo "Installing basic packages"

packages=(
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
zsh
firefox
)


./utils/install_packages.sh "${packages[@]}"

