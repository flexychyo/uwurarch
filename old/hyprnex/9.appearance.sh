#!/bin/bash

#########################################################
# Applying appearance
#########################################################
echo "::: Applying appearance..." 
echo "::: Applying icons for KDE apps..."
kwriteconfig6 --file ~/.config/kdeglobals --group Icons --key Theme 'Tela-circle-pink'
echo "::: Applying icons for GNOME apps..."
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-pink'
echo "::: Applying GNOME theme..."
gsettings set org.gnome.desktop.interface gtk-theme 'Rose-Pine'
echo "::: Turning on GNOME dark scheme..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
echo "::: Setting KDE theme to Kvantum..."
kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle kvantum-dark
kwriteconfig6 --file kdeglobals --group General --key ColorScheme Kvantum
echo "::: Applying cursor theme for KDE..."
kwriteconfig6 --file ~/.config/kcminputrc --group Mouse --key cursorTheme Bibata-Original-Ice
echo "::: Applying cursor theme for GNOME..."
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Original-Ice'
echo "::: Applying cursor theme for Hyprland..."
hyprctl setcursor Bibata-Original-Ice 24
echo "::: Applying wallpapers slideshow service"
systemctl --user daemon-reload
