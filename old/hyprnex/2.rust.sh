#!/bin/bash

#########################################################
# Installing Rust
#########################################################
echo "::: Installing base-devel..."
sudo pacman -S --needed --noconfirm base-devel
echo "::: Checking if Rust installed..."
if command -v rustc >/dev/null 2>&1; then
    echo "::: Rust is already installed."
else
    echo "::: Installing Rust..."
    sudo pacman -S --noconfirm --needed rustup && rustup install stable
    echo "::: Rust installed."
fi
