#!/bin/bash

sudo yay -Sy --noconfirm
sudo yay -S --needed --noconfirm "$@"
