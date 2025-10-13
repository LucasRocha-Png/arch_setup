#!/bin/bash

#yay -S --needed --noconfirm nativefier

# Whatsapp
APP_NAME="WhatsApp"
APP_URL="https://web.whatsapp.com"
ICON_PATH="$HOME/Images/Icons/whatsapp.png"
./utils/nativefier_app.sh $APP_NAME $APP_URL $ICON_PATH

# Chatgpt
APP_NAME="ChatGpt"
APP_URL="https://chatgpt.com/"
ICON_PATH="$HOME/Images/Icons/chatgpt.png"
./utils/nativefier_app.sh $APP_NAME $APP_URL $ICON_PATH
