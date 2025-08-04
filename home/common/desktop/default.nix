{
  pkgs,
  meta,
  ...
}:
{
  imports = [
    (./. + "/${meta.desktop}")

    ../scripts

    # ./alacritty.nix
    ./gaming.nix
    ./gtk.nix
    ./qt.nix
    ./rclone.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    brave
    catppuccin-gtk
    cider
    desktop-file-utils
    discord
    file-roller
    jellyfin-media-player
    loupe
    mpv
    nautilus
    protonmail-desktop
    proton-pass
    papers
    spotify
    thunderbird
  ];

  programs.zen-browser.enable = true;

  fonts.fontconfig.enable = true;
}
