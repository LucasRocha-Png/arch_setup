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
rofi
picom
feh
nemo
lxappearance
)

./utils/install_packages.sh "${packages[@]}"
