#!/usr/bin/fish

# Colors for output
set -l red '\033[0;31m'
set -l green '\033[0;32m'
set -l yellow '\033[1;33m'
set -l blue '\033[0;34m'
set -l magenta '\033[0;35m'
set -l cyan '\033[0;36m'
set -l reset '\033[0m'

# Function for colored output
function echo_color -a color message
    echo -e "$color$message$reset"
end

# Function to check command success
function check_success
    if test $status -eq 0
        echo_color $green "✓ $argv"
        return 0
    else
        echo_color $red "✗ $argv"
        return 1
    end
end

# Check for paru
function check_paru
    if ! command -v paru > /dev/null
        echo_color $red "Error: paru is not installed!"
        echo_color $yellow "Please install paru first and run the script again."
        exit 1
    end
    echo_color $green "✓ paru is available"
end

# Function to install packages
function install_packages
    echo_color $cyan "Installing packages..."

    # Update package database first
    sudo pacman -Sy --noconfirm
    check_success "Package database updated"

    # Install packages
    set packages \
        lsd starship krabby \
        ttf-firacode-nerd ttf-cascadia-code ttf-cascadia-code-nerd \
        ttf-cascadia-mono-nerd ttf-nerd-fonts-symbols \
        ttf-nerd-fonts-symbols-mono noto-fonts-emoji \
        ttf-jetbrains-mono-nerd otf-font-awesome \
        awesome-terminal-fonts noto-fonts ttf-dejavu \
        papirus-icon-theme \
        tela-circle-icon-theme \
        bibata-cursor-theme \
        kvantum kvantum-qt5 \
        gnome-text-editor \
        imv mpv \
        code code-features code-marketplace \
        wget git

    echo_color $blue "Installing: $packages"
    paru -S --needed --noconfirm $packages
    check_success "Main packages installed"
end

# Function to setup fish config
function setup_fish
    echo_color $cyan "Creating Fish configuration..."

    mkdir -p ~/.config/fish

    string join \n \
        'if status is-interactive' \
        '    set -g fish_greeting ""' \
        '' \
        '    # Starship prompt' \
        '    if command -v starship > /dev/null' \
        '        starship init fish | source' \
        '    end' \
        '' \
        '    # Aliases' \
        '    if command -v lsd > /dev/null' \
        '        alias ls="lsd"' \
        '        alias ll="lsd -la"' \
        '        alias la="lsd -A"' \
        '        alias lt="lsd --tree"' \
        '    end' \
        '' \
        '    # Krabby on startup' \
        '    if command -v krabby > /dev/null' \
        '        krabby random' \
        '    end' \
        '' \
        '    # Additional fish settings' \
        '    set -g fish_prompt_pwd_dir_length 0' \
        '    set -g fish_cursor_default block' \
        '    set -g fish_cursor_insert line' \
        '    set -g fish_cursor_replace_one underscore' \
        'end' > ~/.config/fish/config.fish

    check_success "Fish configuration created"
end

# Function to setup kitty
function setup_kitty
    echo_color $cyan "Setting up Kitty..."

    mkdir -p ~/.config/kitty

    string join \n \
        'font_family Cascadia Code' \
        'bold_font auto' \
        'italic_font auto' \
        'bold_italic_font auto' \
        'font_size 12.0' \
        'window_padding_width 5' \
        'map ctrl+c copy_and_clear_or_interrupt' \
        'map ctrl+v paste_from_clipboard' \
        'map ctrl+с copy_and_clear_or_interrupt' \
        'map ctrl+м paste_from_clipboard' \
        'include ./theme.conf' \
        'confirm_os_window_close 0' \
        'background_opacity 0.95' \
        'scrollback_lines 10000' > ~/.config/kitty/kitty.conf

    # Download kitty theme
    set THEMENAME "Hardcore"
    set THEME_URL "https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/$THEMENAME.conf"

    echo_color $blue "Installing Kitty theme ($THEMENAME)..."
    mkdir -p ~/.config/kitty/kitty-themes
    wget -q $THEME_URL -P ~/.config/kitty/kitty-themes/

    if test -f ~/.config/kitty/kitty-themes/$THEMENAME.conf
        ln -sf ~/.config/kitty/kitty-themes/$THEMENAME.conf ~/.config/kitty/theme.conf
        check_success "Kitty theme installed"
    else
        echo_color $yellow "Failed to download Kitty theme, using default"
    end
end

# Function to setup starship
function setup_starship
    echo_color $cyan "Setting up Starship..."

    if command -v starship > /dev/null
        wget -q https://raw.githubusercontent.com/flexychyo/hyprnex/refs/heads/main/.config/starship.toml -O ~/.config/starship.toml
        check_success "Starship config downloaded"
    else
        echo_color $yellow "Starship not installed, skipping"
    end
end

# Function to setup VS Code
function setup_vscode
    echo_color $cyan "Setting up VS Code..."

    mkdir -p ~/.config/Code/User

    string join \n \
        '{' \
        '    "security.workspace.trust.untrustedFiles": "open",' \
        '    "workbench.colorTheme": "Omni",' \
        '    "workbench.iconTheme": "material-icon-theme",' \
        '    "editor.fontFamily": "\"Cascadia Code\", \"Fira Code\", \"JetBrains Mono\", monospace",' \
        '    "editor.fontSize": 14,' \
        '    "editor.fontLigatures": true,' \
        '    "window.titleBarStyle": "custom",' \
        '    "telemetry.telemetryLevel": "off",' \
        '    "update.mode": "none"' \
        '}' > ~/.config/Code/User/settings.json

    check_success "VS Code settings applied"
end

# Function to download and apply uwurarch configs
function setup_uwurarch
    echo_color $magenta "=================================================="
    echo_color $cyan "Downloading and applying uwurarch configurations..."
    echo_color $magenta "=================================================="

    set repo_url "https://github.com/flexychyo/uwurarch.git"
    set temp_dir (mktemp -d)

    echo_color $blue "Cloning repository to temporary directory..."
    git clone --depth 1 $repo_url $temp_dir
    check_success "Repository cloned"

    # Copy .config
    if test -d "$temp_dir/.config"
        echo_color $blue "Copying .config..."
        cp -rf $temp_dir/.config ~/
        check_success ".config copied"
    end

    # Copy .themes
    if test -d "$temp_dir/.themes"
        echo_color $blue "Copying .themes..."
        cp -rf $temp_dir/.themes ~/
        check_success ".themes copied"
    end

    #Copy wallpapers and live wallpapers
    echo_color $cyan "Setting up wallpapers..."
    mkdir -p ~/Pictures/wallpapers
    mkdir -p ~/Pictures/live
    
    if test -d "$temp_dir/wallpapers"
        echo_color $blue "Copying wallpapers..."
        cp -rf $temp_dir/wallpapers/* ~/Pictures/wallpapers/ 2>/dev/null
        check_success "Wallpapers copied"
    end
    
    if test -d "$temp_dir/live"
        echo_color $blue "Copying live wallpapers..."
        cp -rf $temp_dir/live/* ~/Pictures/live/ 2>/dev/null
        check_success "Live wallpapers copied"
    end

    # Copy etc (requires sudo)
    if test -d "$temp_dir/etc"
        echo_color $yellow "Copying etc (requires root privileges)..."
        sudo cp -rf $temp_dir/etc/* /etc/ 2>/dev/null
        check_success "etc copied"
    end

    # Copy usr (requires sudo)
    if test -d "$temp_dir/usr"
        echo_color $yellow "Copying usr (requires root privileges)..."
        sudo cp -rf $temp_dir/usr/* /usr/ 2>/dev/null
        check_success "usr copied"
    end

    # Cleanup
    rm -rf $temp_dir
    echo_color $green "Temporary files cleaned up"
end

# Function to apply appearance settings
function apply_appearance
    echo_color $magenta "=================================================="
    echo_color $cyan "Applying appearance settings..."
    echo_color $magenta "=================================================="

    # KDE settings
    if command -v kwriteconfig6 > /dev/null
        echo_color $blue "Applying icons for KDE applications..."
        kwriteconfig6 --file ~/.config/kdeglobals --group Icons --key Theme 'Tela-circle-pink'
        check_success "KDE icons applied"
    else
        echo_color $yellow "kwriteconfig6 not found, skipping KDE settings"
    end

    # GNOME settings
    if command -v gsettings > /dev/null
        echo_color $blue "Applying settings for GNOME applications..."
        gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-pink'
        gsettings set org.gnome.desktop.interface gtk-theme 'Rose-Pine'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Original-Ice'
        check_success "GNOME settings applied"
    else
        echo_color $yellow "gsettings not found, skipping GNOME settings"
    end

    # KDE theme settings
    if command -v kwriteconfig6 > /dev/null
        echo_color $blue "Setting KDE theme..."
        kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key widgetStyle kvantum-dark
        kwriteconfig6 --file ~/.config/kdeglobals --group General --key ColorScheme Kvantum
        kwriteconfig6 --file ~/.config/kcminputrc --group Mouse --key cursorTheme Bibata-Original-Ice
        check_success "KDE theme applied"
    end

    # Hyprland cursor
    if command -v hyprctl > /dev/null
        echo_color $blue "Applying cursor for Hyprland..."
        hyprctl setcursor Bibata-Original-Ice 24
        check_success "Hyprland cursor applied"
    else
        echo_color $yellow "hyprctl not found, skipping Hyprland cursor setting"
    end

    # Apply Kvantum theme if available
    # Configs are already copied, no need to run kvantummanager as user
    if command -v kvantummanager > /dev/null
        echo_color $blue "Kvantum configs applied (no user intervention needed)"
    end
end

# Main execution function
function main
    echo_color $magenta "=================================================="
    echo_color $yellow "  Setting up Ax Shell and Hyprland for CachyOS"
    echo_color $magenta "=================================================="
    echo ""

    # Check if running as normal user
    if test (id -u) -eq 0
        echo_color $red "Error: Do not run the script as root!"
        echo_color $red "Run as normal user: curl -fsSL get.axeni.de/ax-shell | fish"
        exit 1
    end

    # Check for paru
    check_paru

    # Start installation
    set start_time (date +%s)

    install_packages
    setup_fish
    setup_kitty
    setup_starship
    setup_vscode
    setup_uwurarch
    apply_appearance

    # Calculate time taken
    set end_time (date +%s)
    set duration (math $end_time - $start_time)

    # Final message
    echo_color $magenta "=================================================="
    echo_color $green "✅ Setup successfully completed!"
    echo_color $blue "   Execution time: $duration seconds"
    echo ""
    echo_color $yellow "Recommended actions:"
    echo_color $cyan "  1. Reboot the system to apply all changes"
    echo_color $cyan "  2. Install additional applications as desired"
    echo_color $cyan "  3. Check settings in ~/.config/"
    echo ""
    echo_color $green "Happy using! 🚀"
    echo_color $magenta "=================================================="
end

# Run main function
main