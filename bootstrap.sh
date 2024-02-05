#/bin/zsh

################################################
# coredev-uk/dotfiles - bootstrap.sh
################################################

# Package Manager
if [ "Linux" = `uname` ]; then
  if (command -v yay &> /dev/null); then
    echo "Package Manager: Yay is already installed"
  else
    sudo pacman -S --needed base-devel

    # Install AUR helper
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
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

# Firefox Theme
if (command -v firefox &> /dev/null); then
    if [ "Linux" = `uname` ]; then
        curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
    elif [ "Darwin" = `uname` ]; then
        git clone https://github.com/AdamXweb/WhiteSurFirefoxThemeMacOS.git tmp && cd tmp && bash ./install.sh && cd .. && rm -rf tmp
    elif [ "Windows" = `uname` ]; then
        git clone https://github.com/AdamXweb/WhiteSurFirefoxThemeMacOS.git tmp && cd tmp && bash ./install.sh && cd .. && rm -rf tmp
    else
        echo "Firefox Theme: Your OS is not supported"
    fi
fi

# Shell
if (command -v zsh &> /dev/null); then
  chsh -s $(which zsh)
else
  echo "Shell: Zsh is not installed"
fi

SCRIPT_PATH=$(realpath $(dirname $0))

# Scripts
if [[ "Linux" = `uname` || "Darwin" = `uname` ]]; then
  cp $SCRIPT_PATH/scripts/* $HOME/.local/bin
else
  echo "Scripts: Your OS is not supported"
fi
