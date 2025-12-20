#!/bin/bash

#########################################################
# Installing Paru
#########################################################
echo "::: Checking if Paru installed..."
if command -v paru >/dev/null 2>&1; then
    echo "::: Paru is already installed."
else
    echo "::: Saving currently directory..."
    original_dir=$(pwd)
    # Creating directories
    DOWNLOADS="$HOME/Downloads"
    for DIR in "$DOWNLOADS"; do
        if [ ! -d "$DIR" ]; then
            echo "::: Creating directory: $DIR"
            mkdir -p "$DIR"
        fi
    done
    echo "::: Installing Paru..."
    cd ~/Downloads
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd "$original_dir"
    rm -rf ~/Downloads/paru
fi