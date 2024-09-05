{ pkgs, desktop, ... }:
{
  imports = [
    ./alacritty.nix
    ./rofi.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    pavucontrol
  ];

  fonts.fontconfig.enable = true;
}