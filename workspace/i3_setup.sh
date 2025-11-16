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
  wine
)

multimedia_packages=(
  vlc
  vlc-plugin-ffmpeg 
  vlc-plugin-x265 
  ffmpeg 
  firefox
  discord
  obs-studio
  inkscape
  gimp
  audiacity
  kdenlive
  shotwell
)

yay_multimedia_packages=(
  pamac
)

graphics_packages=(
  lxappearance
  kvantum
  gnome-tweaks
  gnome-themes-extra
  kde-gtk-config
)

graphics_packages_yay=(
  gnome-themes-extra-gtk2
  adwaita-qt5-git
  adwaita-qt6-git
)

login_manager=(
  ly
)

pacman_fonts=(
  noto-fonts-emoji   
  ttf-fira-code
  ttf-firacode-nerd
  ttf-hack-nerd
)

../utils/pacman_ip.sh "${base_packages[@]}"
../utils/pacman_ip.sh "${i3_packages[@]}"
../utils/pacman_ip.sh "${utils_packages[@]}"
../utils/pacman_ip.sh "${multimedia_packages[@]}"
../utils/pacman_ip.sh "${graphics_packages[@]}"
../utils/pacman_ip.sh "${login_manager[@]}"
../utils/pacman_ip.sh "${pacman_fonts[@]}"
../utils/yay_ip.sh "${graphics_packages_yay[@]}"
../utils/yay_ip.sh "${yay_multimedia_packages[@]}"

sudo systemctl enable --now ly
GTK_THEME=Adwaita:dark
GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
QT_STYLE_OVERRIDE=Adwaita-Dark