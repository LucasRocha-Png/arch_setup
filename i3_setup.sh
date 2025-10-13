#!/bin/bash

packages=(
xorg-server
xorg-xinit
xorg-apps
i3-wm
i3lock
i3status
lightdm
lightdm-gtk-greeter
polybar
dmenu
picom
feh
nemo
lxappearance 
brightnessctl
maim
xclip

merkuro
vlc
file-roller
discord
firefox
playerctl
)

./utils/install_packages.sh "${packages[@]}"
