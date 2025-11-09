#!/bin/bash

packages=(
kitty
zsh
exa
)

../utils/pacman_ip.sh "${packages[@]}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chsh -s /bin/zsh
echo "plugins=(git zsh-syntax-highlighting zsh-autosuggestions)" >> ~/.zshrc
