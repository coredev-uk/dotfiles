#!/bin/sh

# download vim-plug if missing
directory_exists() {
    test -d "$1"
}


packer_install() {
	local PACKER_DIRECTORY="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/packer.nvim"

	if ! directory_exists "$PACKER_DIRECTORY"; then
		echo 'Installing a package manager for Neovim...'
		git clone "https://github.com/wbthomason/packer.nvim" "$PACKER_DIRECTORY"
		echo 'Done.'
	fi
}

packer_install
nvim -u NONE \
    +'autocmd User PackerComplete quitall' \
    +'lua require("core.plugins")' \
    +'lua require("packer").sync()'
