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
    pwvucontrol
    (discord.override {
      withVencord = true;
    })
    jellyfin-media-player
  ];

  fonts.fontconfig.enable = true;
}
