#!/bin/bash

# Verifica argumentos
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <AppName> <URL> <IconPath>"
    exit 1
fi

APP_NAME="$1"
URL="$2"
ICON_PATH="$3"

INSTALL_DIR="$HOME/.local/share/$APP_NAME"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/$APP_NAME.desktop"

# Cria o app com Nativefier
echo "Creating $APP_NAME with Nativefier..."
nativefier "$URL" --name "$APP_NAME" --icon "$ICON_PATH" --overwrite

BUILD_DIR="${APP_NAME}-linux-x64"

# Verifica se a build foi criada
if [ ! -d "$BUILD_DIR" ]; then
    echo "Error: Build folder $BUILD_DIR not found."
    exit 1
fi

# Remove instalação anterior, se existir
if [ -d "$INSTALL_DIR" ]; then
    echo "App already exists."
    #rm -rf "$INSTALL_DIR"
    rm -rf "$BUILD_DIR"
    exit 1
fi

# Move nova build
echo "Installing $APP_NAME to $INSTALL_DIR..."
mv "$BUILD_DIR" "$INSTALL_DIR"

# Garante que a pasta de desktop exista
mkdir -p "$DESKTOP_DIR"

# Cria arquivo .desktop
echo "Creating desktop entry..."
cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=$APP_NAME
Exec=$INSTALL_DIR/$APP_NAME
Icon=$ICON_PATH
Type=Application
EOL

chmod +x "$INSTALL_DIR/$APP_NAME"
echo "Done! You can now find $APP_NAME in your application menu."

# Garante que ~/.local/bin existe
mkdir -p ~/.local/bin

# Cria symlink para facilitar execução pelo terminal
ln -sf "$INSTALL_DIR/$APP_NAME" "$HOME/.local/bin/$APP_NAME"

echo "You can now run the app by typing '$APP_NAME' in the terminal."
