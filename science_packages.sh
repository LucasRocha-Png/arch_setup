#!/bin/bash

echo "Installing science packages"

packages=(
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

./utils/install_packages.sh "${packages[@]}"

yay -S --needed --noconfirm qucs-s # Circuit Simulator
yay -S --needed --noconfirm zotero
