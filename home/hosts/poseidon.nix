{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Base Packages
    agenix
    bat
    curl
    eza
    file
    git
    jq
    killall
    lsof
    ripgrep
    rsync
    tree
    unzip
    usbutils
    vim

    # Extra
    # discord
    # whatsapp-for-mac
  ];

  # programs.zen-browser.enable = true;
}
