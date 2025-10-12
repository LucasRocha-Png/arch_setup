#!/bin/bash

packages=(
git
openssh
)

./utils/install_packages.sh "${packages[@]}"
sudo systemctl enable --now sshd

read -p "Type your name: " NAME
git config --global user.name $NAME

read -p "Type your email: " EMAIL
git config --global user.email $EMAIL

ssh-keygen -t ed25519 -C $EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo -e "\nYour key is:\n"
cat ~/.ssh/id_ed25519.pub

