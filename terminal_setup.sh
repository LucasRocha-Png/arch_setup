#!/bin/bash

packages=(
kitty
zsh
)

./utils/install_packages.sh "${packages[@]}"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chsh -s /bin/zsh
echo "Put this at ~/.zshrc"
echo "plugins=(git zsh-syntax-highlighting zsh-autosuggestions)"