#!/bin/sh

# I use arch btw

if ! command -v paru >/dev/null 2>&1; then
	echo "Installing pacman packages"

	sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si

	paru -S git neovim neofetch alacritty
fi

