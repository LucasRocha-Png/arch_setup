#!/bin/bash 

echo "Configurating Timezone."

timedatectl set-timezone America/Sao_Paulo
hwclock --systohc
timedatectl set-ntp true

echo "Configurating keyboard."
locale-gen
echo LANG=en-US.UTF-8 > /etc/locale.conf
echo KEYMAP=br-abnt2 >> /etc/locale.conf
