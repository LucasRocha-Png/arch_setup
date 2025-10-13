#!/bin/bash

packages=(
xorg-server
xorg-xinit
xorg-apps
i3-wm
i3lock
i3status
ly
polybar
dmenu
picom
feh
nemo
brightnessctl
maim
xclip
vlc
ark
merkuro
discord
firefox
playerctl
gnome-calendar
qcalculate-gtk
gnome-clock
)

./utils/install_packages.sh "${packages[@]}"
sudo systemctl enable --now ly