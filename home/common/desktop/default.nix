{
  pkgs,
  desktop,
  inputs,
  ...
}:
let
  krisp-patcher =
    pkgs.writers.writePython3Bin "krisp-patcher"
      {
        libraries = with pkgs.python3Packages; [
          capstone
          pyelftools
        ];
        flakeIgnore = [
          "E501" # line too long (82 > 79 characters)
          "F403" # 'from module import *' used; unable to detect undefined names
          "F405" # name may be undefined, or defined from star imports: module
        ];
      }
      (
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://pastebin.com/raw/8tQDsMVd";
            sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
          }
        )
      );
in
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
    # (discord.override {
    #   withVencord = true;
    # })
    discord
    google-chrome
    jellyfin-media-player
    krisp-patcher
    protonmail-desktop
    protonvpn-gui
    papers
  ];

  fonts.fontconfig.enable = true;
}
