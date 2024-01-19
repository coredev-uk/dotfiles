#!/bin/sh

OS=$(uname -o)


if [ "$OS" = "Darwin" ]; then

    # Install homebrew
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install packages
    if [ -f "$HOME/.config/yadm/packages" ]; then
        echo "Updating homebrew bundle"
        brew bundle --file $HOME/.config/yadm/packages -v

        # Update the shell
        fish_path=$(which fish)
        chsh -s $fish_path
    fi
        
elif [ "$OS" = "GNU/Linux" ]; then

    if ! command -v yay >/dev/null 2>&1; then
        echo "Installing Pacman Helper"

        # Install base-devel
        sudo pacman -S --needed base-devel

        # Install yay (AUR helper)
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si

        # Install packages
        yay -S --needed - < $HOME/.config/yadm/packages
    fi

fi