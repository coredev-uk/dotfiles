#/bin/zsh

################################################
# coredev-uk/dotfiles - bootstrap.sh
################################################

SCRIPT_PATH=$(realpath $(dirname $0))

if (! command -v stow &> /dev/null); then
  echo "Stow must be installed!"
  exit;
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
  if [[ -f $SCRIPT_PATH/install_state && $(cat $SCRIPT_PATH/install_state | grep 'firefox-theme') ]]; then
    echo "Firefox Theme: Theme already installed."
  else
    if [ "Linux" = `uname` ]; then
      echo "Firefox Theme: Installing firefox-gnome-theme..."
      curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
      echo "firefox-theme" > $SCRIPT_PATH/install_state
    elif [ "Darwin" = `uname` ]; then
      echo "Firefox Theme: Installing WhiteSurFirefoxThemeMacOS..."
      git clone https://github.com/AdamXweb/WhiteSurFirefoxThemeMacOS.git tmp && cd tmp && bash ./install.sh && cd .. && rm -rf tmp
      echo "firefox-theme" > $SCRIPT_PATH/install_state
    else
      echo "Firefox Theme: Your OS is not supported"
    fi
  fi
fi

# Shell
if (command -v zsh &> /dev/null); then
  if [ `$SHELL` != `which zsh` ]; then
    echo "Shell: Changing shell to Zsh"
    chsh -s $(which zsh)
  else
    echo "Shell: Zsh is already the default shell"
  fi
else
  echo "Shell: Zsh is not installed"
fi


# Scripts
if [[ "Linux" = `uname` || "Darwin" = `uname` ]]; then
  cp $SCRIPT_PATH/scripts/* $HOME/.local/bin
else
  echo "Scripts: Your OS is not supported"
fi
