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
btop
unzip
stow
wget
zsh
dex
npm
nodejs
tmux
power-profiles-daemon
)

./utils/install_packages.sh "${packages[@]}"
sudo systemctl enable --now power-profiles-daemon
