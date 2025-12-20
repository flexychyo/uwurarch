#!/bin/bash

#########################################################
# Installing Chaotic Aur
#########################################################
chaotic_error=0
echo "Configuring Chaotic AUR..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
if ! sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'; then
    echo "(!) Error: Failed to download or install chaotic-keyring.pkg.tar.zst."
    echo "(!) Please check your internet connection or try again later."
    echo "(!) URL: https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst"
    chaotic_error=1
fi
sudo pacman -Sy
if ! sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'; then
    echo "(!) Error: Failed to download or install chaotic-mirrorlist.pkg.tar.zst."
    echo "(!) Please check your internet connection or try again later."
    echo "(!) URL: https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"
    chaotic_error=1
fi
if [ $chaotic_error -ne 1 ]; then
    if ! grep -q 'chaotic-mirrorlist' /etc/pacman.conf; then
        echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf > /dev/null
        echo "::: The section [chaotic-aur] added in /etc/pacman.conf"
    else
        echo "::: The section [chaotic-aur] already exists in /etc/pacman.conf"
    fi
    echo "::: Chaotic AUR has been configured successfully."
else
    echo "::: There was an error earlier, so the configuration was not modified."
    echo "::: Chaotic AUR has not been configured. See errors above."
fi