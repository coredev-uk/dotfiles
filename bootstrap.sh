#/bin/zsh

################################################
# coredev-uk/dotfiles - bootstrap.sh
################################################

SCRIPT_PATH=$(realpath $(dirname $0))

if (! command -v stow &> /dev/null); then
    echo "Stow must be installed!"
    exit 1;
fi

# Git Config Symlinking for Mac and Linux
if [ "Linux" = `uname` ]; then
    ln -sf $SCRIPT_PATH/gitconfig-linux $HOME/.gitconfig
elif [ "Darwin" = `uname` ]; then
    ln -sf $SCRIPT_PATH/gitconfig-mac $HOME/.gitconfig
else
    echo "Git Config: No gitconfig specified for your OS."
fi

# Package Manager
if [ "Linux" = `uname` ]; then
    if (command -v paru &> /dev/null); then
        echo "Package Manager: Paru is already installed"
    else
        sudo pacman -S --needed base-devel
        # Install AUR helper
        git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si
    fi
elif [ "Darwin" = `uname` ]; then
    if (command -v brew &> /dev/null); then
        echo "Package Manager: Homebrew is already installed"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
else
    echo "Package Manager: Your OS is not supported"
fi

# Shell
if command -v zsh &> /dev/null; then
    if [[ $SHELL = **zsh** ]]; then
        echo "Shell: Zsh is already the default shell"
    else
        echo "Shell: Changing shell to Zsh"
        chsh -s $(which zsh)
    fi
else
    echo "Shell: Zsh is not installed"
fi

# FNM (Node Version Manager in R*)
if [[ (Linux = `uname` && ! -f "$HOME/.local/share/fnm/fnm") || (Darwin = `uname` && ! -f "/opt/homebrew/bin/fnm") ]]; then
    curl -fsSL https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash
fi
