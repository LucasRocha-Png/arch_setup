#!/bin/bash

base_packages=(
  xorg-server
  xorg-xinit
  xorg-apps
)

i3_packages=(
  i3-wm
  i3lock
  i3status
  dmenu
  rofi
  polybar
  picom
  dunst
  brightnessctl
)

utils_packages=(
  feh                  # Imagens / wallpaper
  nemo                 # Gerenciador de arquivos
  maim                 # Screenshot
  xclip                # Copiar imagem/arquivo
  playerctl            # Controle de mídia
  ark                  # Compactação/descompactação
  qalculate-gtk        # Calculadora científica
  gnome-calendar       # Calendário
  gnome-clocks         # Relógio e temporizador
)

multimedia_packages=(
  vlc
  firefox
  discord
  obs-studio
)

graphics_packages=(
  inkscape
)

login_manager=(
  ly
)

pacman_fonts=(
  noto-fonts-emoji   
  ttf-fira-code
)

yay_fonts={
  apple_fonts
}

../utils/pacman_ip.sh "${base_packages[@]}"
../utils/pacman_ip.sh "${i3_packages[@]}"
../utils/pacman_ip.sh "${utils_packages[@]}"
../utils/pacman_ip.sh "${multimedia_packages[@]}"
../utils/pacman_ip.sh "${graphics_packages[@]}"
../utils/pacman_ip.sh "${login_manager[@]}"
../utils/pacman_ip.sh "${pacman_fonts[@]}"
../utils/yay_ip.sh "${yay_fonts[@]}"

sudo systemctl enable --now ly
