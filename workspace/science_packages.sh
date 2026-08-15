#!/bin/bash

echo "Installing science packages"

office=(
    evince
    enter-tex
    texlive-core
    texlive-bin
    texlive-latexextra
    texlive-fontsextra
    texlive-langportuguese
    planner
    pandoc
    mousepad
    kruler
    minder # 1.17
)

yay_office=(
    zotero
    erpnext
    onlyoffice-bin
    gnome-shell-pomodoro #  0.28.1-2
    gnome-shell-pomodoro-debug #  0.28.1-2
    i3-gnome-pomodoro-git # 1:0.1.0.r92.7fe1895-2
)

../utils/pacman_ip.sh "${office[@]}"
../utils/yay_ip.sh "${yay_office[@]}"

code_apps=(
    downgrade
    jupyterlab
    python-ipykernel
    imhex
    gtkwave
    ghdl
    iverilog
    sigrok-cli
    jupyterlab
    code
    python-seaborn
    jupyter-notebook 
    jupyterlab 
    zeal
    visidata
)

yay_code=(
    wireshark-git
)
../utils/pacman_ip.sh "${code_apps[@]}"
../utils/yay_ip.sh "${yay_code[@]}"


math=(
geogebra
octave
gnuplot
)

yay_math=(
openmodelica
)
../utils/yay_ip.sh "${yay_math[@]}"
../utils/pacman_ip.sh "${math[@]}"


td_modeling=(
freecad
librecad
)

yay_td_modeling=(
prusa-slicer 
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
    ltspice
    pulseview 
    logisim-evolution
    openems
    quartus-free
    modelsim
    stm32cubemx
    stm32cubeide
    stm32cubeprog
    stm32flash
    wireviz
    gaphor
    qelectrotech
    ktechlab
    logisim-evolution-bin
)

../utils/pacman_ip.sh "${eletrical[@]}"
../utils/yay_ip.sh "${yay_eletrical[@]}"

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

company_yay=(
)
../utils/yay_ip.sh "${company_yay[@]}"

#yay_automation=(
#    gazebo
#)
#../utils/yay_ip.sh "${yay_automation[@]}"

#./science_utils/openplc_install.sh
