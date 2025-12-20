<p align="center">
  <img src="/src/hyprnex.png" alt="Logo" width="200"/>
</p>


# Hyprnex

![screenshot](/src/sc1.png)

This script installs Hyprland on a clean Arch or any Arch based distro like Endeavour OS.

If you need a guide on installing Arch, open `install_arch`.

If you want to install wsl with terminal like in the screenshot below, open `install_wsl`

![screenshot](/src/terminal.png)

# Installation 

It is assumed that you have already installed the drivers for the video card during the OS installation. Therefore, this script does not affect them.

The script installs git versions of the packages `hyprland-git` `hypridle-git` `hyprlock-git`, if you already have `hyprland` installed, then replace the names of the packages in the `7.dependencies.sh` with `hyprland` `hypridle` `hyprlock` to avoid conflicts.

The script is divided into parts to make it easier to control the installation.

Run in order:

```bash
cd ~
git clone https://github.com/mvrshmvllxw/hyprnex
cd hyprnex
./1.pacman.sh
./2.rust.sh
./3.paru.sh
./4.chaotic.sh
./5.fonts.sh
./6.terminal.sh
./7.dependencies.sh
./8.configs.sh
./9.appearance.sh
./10.flatcraft.sh
```
### Setting up

While there are temporary commands to manage settings, type `hyprnex`

### DE

- wm: hyprland
- bar: waybar
- notifies: mako
- app menu: rofi
- lockscreen: hyprlock + hypridle
- wallpapers: swww
- logout menu: wlogout
- terminal: kitty (hardcore theme,fish shell, lsd, starship with theme from Garuda Linux)
- kde and gnome theme: rose pin
- login screen: sddm (austronaut theme)
- cursor: bibata
- icons: tela-circle
- additional apps: vscode (editor, omni theme/material-icon-theme), telegram-desktop, firefox, imv (image viewer), mpv (video viewer), wayshot (screenshots), nekoray (v2ray vpn client), obs-studio (screen recorder), dolphin (files), krabby (pokemons), fastfetch (system info), btop (catppuccin macchiato theme) and htop (processes viewers)

# Additional

### Telegram theme

```
https://t.me/addtheme/BChppF8BUJCY9EW9
```

### Firefox theme

```
https://addons.mozilla.org/en-US/firefox/addon/nezuko/
```

### Firefox delete window close button

Type `about:config` in URL bar.

Set `toolkit.legacyUserProfileCustomizations.stylesheets` to true.

Type `about:support`. Copy address from Open profile direcory button.

(for example /home/mvrshmvllxw/.mozilla/firefox/gckgzl7s.default-release)

Create file directory 'chrome':

mkdir -p /home/mvrshmvllxw/.mozilla/firefox/`gckgzl7s.default-release`/chrome`

And file:

sudo nano  /home/mvrshmvllxw/.mozilla/firefox/`gckgzl7s.default-release`/chrome/userChrome.css

Add to file:

`.titlebar-buttonbox-container{display:none} `

# NVidia drivers

If you are installing Hyprland not on a clean Arch with pre-installed Hyprland and video drivers, then you should read https://wiki.hyprland.org/Nvidia/

# Updates

If you need update this repo write `git pull`