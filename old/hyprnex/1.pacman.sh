#!/bin/bash

#########################################################
# Pacman configuring
#########################################################
echo "::: Pacman configuring..."
gpg --refresh-keys
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --noconfirm archlinux-keyring
sudo sed -i 's/#Color/Color/' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
if ! grep -q '^ILoveCandy' /etc/pacman.conf; then
    sudo sed -i '/^#DisableSandbox/a ILoveCandy' /etc/pacman.conf || sudo sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
fi
echo "::: Updating system..."
sudo pacman -Su --noconfirm 
echo "::: Pacman configured."

#########################################################
# Updating mirrors
#########################################################
echo "::: Updating mirrors with Reflector..."
sudo pacman -S --needed --noconfirm reflector rsync
sudo reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist
echo "::: Updating system..."
sudo pacman -Syu