{ pkgs, desktop, ... }:
{
  imports = [
    (./. + "/${desktop}")

    ../dev
    ../scripts

    ./alacritty.nix
    ./gtk.nix
    ./rclone.nix
    ./qt.nix
    ./xdg.nix
  ];

  programs = {
    # firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    (bluemail.overrideAttrs (oldAttrs: {
      # https://bluemail.me/help/linux-gpu-issue/
      desktopItems = [
        (makeDesktopItem {
          name = "bluemail";
          icon = "bluemail";
          exec = "bluemail --in-process-gpu %U";
          desktopName = "BlueMail";
          comment = oldAttrs.meta.description;
          genericName = "Email Reader";
          mimeTypes = [
            "x-scheme-handler/me.blueone.linux"
            "x-scheme-handler/mailto"
          ];
          categories = [ "Office" ];
        })
      ];
    }))
    catppuccin-gtk
    cider
    google-chrome
    desktop-file-utils
    (discord.override {
      withVencord = true;
    })
    vesktop
    jellyfin-media-player
    papers
    pwvucontrol
  ];

  fonts.fontconfig.enable = true;
}
