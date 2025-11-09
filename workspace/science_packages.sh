#!/bin/bash

echo "Installing science packages"

pacman_packages=(
okular
libreoffice-still
texstudio
texlive-core
texlive-bin
texlive-latexextra
texlive-fontsextra
texlive-langportuguese
jupyterlab
python-ipykernel
gnuplot
sagemath
octave
freecad
geogebra
maxima
ngspice # Circuit Simulator
)

yay_packages={
qucs-s 
zotero
}

../utils/pacman_ip.sh "${pacman_packages[@]}"
../utils/yay_ip.sh "${yay_packages[@]}"


