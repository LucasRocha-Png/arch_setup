#!/bin/bash

yay_utils_packages=(
  nodejs-nativefier
)

../utils/yay_ip.sh "${yay_utils_packages[@]}"

# Whatsapp
APP_NAME="WhatsApp"
APP_URL="https://web.whatsapp.com"
ICON_PATH="./icons/whatsapp.png"
../utils/nativefier_app.sh $APP_NAME $APP_URL $ICON_PATH
