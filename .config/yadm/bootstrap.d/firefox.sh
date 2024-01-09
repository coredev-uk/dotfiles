#!/bin/sh


# https://raw.githubusercontent.com/vinceliuice/WhiteSur-firefox-theme/main/install.sh


OS=$(uname -o)

if (command -v firefox &> /dev/null); then

    if [ "$OS" = "GNU/Linux" ]; then
        curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
    elif [ "$OS" = "Darwin" ]; then
        git clone https://github.com/AdamXweb/WhiteSurFirefoxThemeMacOS.git tmp && cd tmp && bash ./install.sh && cd .. && rm -rf tmp
    elif [ "$OS" = "Windows" ]; then
        git clone https://github.com/AdamXweb/WhiteSurFirefoxThemeMacOS.git tmp && cd tmp && bash ./install.sh && cd .. && rm -rf tmp
    else
        echo "Your OS is not supported"
    fi

fi