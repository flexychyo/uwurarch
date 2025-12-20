#!/bin/bash

#########################################################
# Terminal configuring
#########################################################
echo "::: Setting up terminal..."
paru -S --needed --noconfirm fish kitty lsd starship krabby
echo "::: Copying configs..."
cp -rf .config/fish ~/.config/
cp -rf .config/kitty ~/.config/
cp -f .config/starship.toml ~/.config/
# Set Fish default shell
echo "::: Setting fish as the default shell..."
chsh -s $(which fish)

#########################################################
# Creating user dirs
#########################################################
echo "::: Configuring user dirs..."
sudo pacman -S --needed --noconfirm xdg-user-dirs
xdg-user-dirs-update

# script to set theme from github
# THEMENAME="Hardcore"
# THEME_URL="https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/$THEMENAME.conf"
# wget "$THEME_URL" -P ~/.config/kitty/kitty-themes/
# ln -sf ~/.config/kitty/kitty-themes/$THEMENAME.conf ~/.config/kitty/theme.conf