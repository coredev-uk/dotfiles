{ pkgs, desktop, ... }:
{
  imports =
    [
      ./alacritty.nix
      ./rofi.nix
      ./system
    ]
    ++ (
      if desktop == "i3" then
        [
          ./polybar.nix
          ./picom.nix
        ]
      else
        [ ]
    );

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    pavucontrol
    discord-canary
    jellyfin-media-player
  ];

  fonts.fontconfig.enable = true;
}
