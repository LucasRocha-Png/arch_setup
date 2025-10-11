#!/bin/bash 

echo "Configurating Timezone to America/Sao_Paulo."

timedatectl set-timezone America/Sao_Paulo
hwclock --systohc
timedatectl set-ntp true

echo "Configurating keyboard to br-abnt2."
locale-gen
echo LANG=en-US.UTF-8 > /etc/locale.conf
echo KEYMAP=br-abnt2 >> /etc/locale.conf
