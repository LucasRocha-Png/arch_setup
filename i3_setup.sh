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

./utils/install_packages.sh "${base_packages[@]}"
./utils/install_packages.sh "${i3_packages[@]}"
./utils/install_packages.sh "${utils_packages[@]}"
./utils/install_packages.sh "${multimedia_packages[@]}"
./utils/install_packages.sh "${graphics_packages[@]}"
./utils/install_packages.sh "${login_manager[@]}"

sudo systemctl enable --now ly
