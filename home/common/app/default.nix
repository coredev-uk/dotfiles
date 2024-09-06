{ pkgs, desktop, ... }:
{
  imports = [
    ./alacritty.nix
    ./rofi.nix
    
    ./system
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    pavucontrol
    discord-canary
  ];

  fonts.fontconfig.enable = true;
}