{ pkgs, desktop, ... }:

{
  imports = [
    (./. + "/${desktop}")

    ./app
  ];

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    libnotify
    xdg-utils
  ];

  fonts.fontconfig.enable = true;
}