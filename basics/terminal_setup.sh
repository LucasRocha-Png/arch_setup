#!/bin/bash

packages=(
kitty
zsh
exa
fortune-mod
zsh-autosuggestions 
zsh-syntax-highlighting
zsh-completions
)

../utils/pacman_ip.sh "${packages[@]}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s /bin/zsh
echo "plugins=(git sudo extract thefuck zsh-syntax-highlighting zsh-autosuggestions)" >> ~/.zshrc
