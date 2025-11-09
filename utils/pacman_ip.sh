#!/bin/bash

sudo pacman -Sy --noconfirm
sudo pacman -S --needed --noconfirm "$@"
