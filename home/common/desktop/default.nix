{
  pkgs,
  desktop,
  inputs,
  ...
}:
{
  imports = [
    (./. + "/${desktop}")

    ../dev
    ../scripts

    ./alacritty.nix
    ./gaming.nix
    ./gtk.nix
    ./qt.nix
    ./rclone.nix
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
    desktop-file-utils
    (discord-canary.override {
      withVencord = true;
    })
    google-chrome
    jellyfin-media-player
    protonmail-desktop
    papers
    pwvucontrol
    vesktop
  ];

  fonts.fontconfig.enable = true;
}
