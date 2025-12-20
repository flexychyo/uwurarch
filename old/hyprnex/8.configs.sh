#!/bin/bash

#########################################################
# Copying configuration files
#########################################################
# Creating directories
echo "::: Creating directories..."
BIN_DIR="$HOME/.local/share/bin"
DIRSCR="$HOME/Pictures/Screenshots"
WALLPAPERS="$HOME/Pictures/Wallpapers"
LIVE="$HOME/Pictures/Live"
DOWNLOADS="$HOME/Downloads"
THEMES="$HOME/.themes"
for DIR in "$BIN_DIR" "$DIRSCR" "$DOWNLOADS" "$WALLPAPERS" "$LIVE" "$THEMES"; do
    if [ ! -d "$DIR" ]; then
        echo "::: Creating directory: $DIR"
        mkdir -p "$DIR"
    fi
done
echo "::: Copying configuration files..."
cp -rf .config/* ~/.config/
cp -rf .themes/* ~/.themes/
sudo cp -rf usr/* /usr/
sudo cp -rf etc/* /etc/
cp -rf wallpapers/* ~/Pictures/Wallpapers/
cp -rf live/* ~/Pictures/Live
echo "::: Done."