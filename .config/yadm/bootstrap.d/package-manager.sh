#!/bin/sh

system_type=$(uname -s)

# Install Homebrew on macOS
if [ "$system_type" = "Darwin" ]; then

  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if [ -f "$HOME/.Brewfile" ]; then
    echo "Updating homebrew bundle"
    brew bundle --global
		chsh -s /opt/homebrew/bin/fish
  fi
# Install packages in Linux
elif [ "$system_type" = "Linux" ]; then
	. /etc/os-release

	if [ "$NAME" != "Arch Linux" ]; then
		echo "This script is only for Arch Linux"
		exit 1
	fi

	if ! command -v paru >/dev/null 2>&1; then
		echo "Installing pacman packages"

		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si

		paru -S git neovim neofetch alacritty
	fi
fi
