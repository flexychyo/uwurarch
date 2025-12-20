#!/bin/bash

#########################################################
# Installing dependencies
#########################################################
echo "::: Installing dependencies with paru..."
if ! command -v paru &> /dev/null; then
    echo -e "\e[35m(!) Paru is not installed. Please install paru first.\e[0m"
    exit 1
fi
sudo pacman -Syu
# Python
paru -S --needed --noconfirm python python-pip tk tcl python-pyqt6
# Wayland and X11
paru -S --needed --noconfirm hyprland-git wayland-protocols xorg-xwayland wlroots
# Graphics and Video Libraries
paru -S --needed --noconfirm mesa pixman cairo pango libxcomposite libxrender qt5-wayland qt6-wayland qt5-imageformats ffmpegthumbs imagemagick swww
# Sound and Multimedia Libraries
paru -S --needed --noconfirm pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-audio pipewire-jack gst-plugin-pipewire alsa-utils pamixer
# Development Tools
paru -S --needed --noconfirm db ninja gcc cmake meson clang parallel
# General Libraries
paru -S --needed --noconfirm libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxkbcommon xcb-util-wm fmt spdlog gtkmm3 libdbusmenu-gtk3 \
upower libmpdclient sndio gtk-layer-shell scdoc qt5ct qt6ct kconfig polkit polkit-kde-agent polkit-gnome libnotify xdg-utils shared-mime-info
# Themes
paru -S --needed --noconfirm papirus-icon-theme tela-circle-icon-theme-all bibata-cursor-theme kvantum kvantum-qt5 numix-circle-icon-theme-git 
# Utilities and Applications
paru -S --needed --noconfirm mako network-manager-applet bluez bluez-utils blueman brightnessctl udiskie xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk \
nautilus dolphin gnome-text-editor waybar nwg-shell tofi wlogout wayshot archlinux-xdg-menu less hypridle-git hyprlock-git jq \
xdg-desktop-portal-kde nwg-displays fastfetch htop btop
# Viewer and Editor Applications
paru -S --needed --noconfirm code code-features code-marketplace firefox telegram-desktop imv mpv
# System Utilities
paru -S --needed --noconfirm kde-cli-tools kservice5 pacman-contrib python-pyamdgpuinfo xorg-xinput seatd
# VPN
paru -S --needed --noconfirm nekoray sing-geosite sing-geoip
# Fixes for Steam
sudo pacman -S --needed --noconfirm lib32-libx11 lib32-libxcomposite lib32-libxrandr lib32-libxinerama lib32-libxcursor lib32-mesa lib32-vulkan-icd-loader \
lib32-pipewire lib32-glibc lib32-gtk2 lib32-gtk3 lib32-gnutls lib32-libpulse lib32-openal
# Nvidia
# paru -S --needed --noconfirm nvidia


