#!/bin/bash

echo "::: Saving currently directory..."
echo "::: Installing Flatpak..."
original_dir=$(pwd)
sudo pacman -S --needed --noconfirm flatpak
if ! command -v snap &> /dev/null; then
    DOWNLOADS="$HOME/Downloads"
    for DIR in "$DOWNLOADS"; do
        if [ ! -d "$DIR" ]; then
            echo "::: Creating directory: $DIR"
            mkdir -p "$DIR"
        fi
    done
    echo "::: Installing Snapcraft..."
    cd ~/Downloads
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si
    sudo systemctl enable --now snapd.socket
    sudo pacman -S --needed --noconfirm apparmor
    sudo systemctl start apparmor.service
    sudo systemctl enable --now snapd.apparmor.service
else
    echo "::: Snapcraft already installed."
fi
# Return to the original directory
cd "$original_dir"
rm -rf ~/Downloads/snapd