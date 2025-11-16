#!/bin/bash

echo "Installing science packages"

office=(
okular
libreoffice-still
texstudio
texlive-core
texlive-bin
texlive-latexextra
texlive-fontsextra
texlive-langportuguese
planner
pandoc
)

yay_office=(
zotero
)

../utils/pacman_ip.sh "${office[@]}"
../utils/yay_ip.sh "${yay_office[@]}"

code_apps=(
jupyterlab
python-ipykernel
jupyter-notebook
imhex
gtkwave
ghdl
sigrok-cli
jupyterlab
code
python-numpy 
python-scipy 
python-pandas 
python-matplotlib
python-sympy 
python-scikit-learn 
python-seaborn
jupyter-notebook 
jupyterlab 
python-altair
python-tensorflow 
python-torch 
python-torchvision
)

yay_code=(
    wireshark-git
    python-pytorch 
    python-keras
)
../utils/pacman_ip.sh "${code_apps[@]}"
../utils/yay_ip.sh "${yay_code[@]}"


math=(
geogebra
octave
gnuplot
)

yay_math=(
scilab-bin
openmodelica
sagemath
)
../utils/yay_ip.sh "${yay_math[@]}"
../utils/pacman_ip.sh "${math[@]}"


td_modeling=(
freecad
librecad
)

yay_td_modeling=(
orca-slicer 
)
../utils/pacman_ip.sh "${td_modeling[@]}"
../utils/yay_ip.sh "${yay_td_modeling[@]}"

mechanics=(
    gcc 
    gcc-fortran
    yaml-cpp
    paraview
    avogadro2-bin
)

yay_mechanics=(
    calculix-cgx
    calculix-ccx
    openfoam-org 
    gmsh
    cantera-git
)
../utils/pacman_ip.sh "${mechanics[@]}"
../utils/yay_ip.sh "${yay_mechanics[@]}"


eletrical=(
ngspice
kicad
ghidra
rizin
gnuradio
)

yay_eletrical=(
qucs-s
pulseview 
openems
)

../utils/pacman_ip.sh "${eletrical[@]}"
../utils/yay_ip.sh "${yay_eletrical[@]}"

connectivity=(
)

yay_connectivity=(
    qbittorrent
    tor-browser-bin
)
../utils/pacman_ip.sh "${connectivity[@]}"
../utils/yay_ip.sh "${yay_connectivity[@]}"


geography=(
stellarium
marble
gnome-maps
kstars
)

../utils/pacman_ip.sh "${geography[@]}"


#yay_automation=(
#    gazebo
#)
#../utils/yay_ip.sh "${yay_automation[@]}"

#./science_utils/openplc_install.sh
