{
  pkgs,
  desktop,
  ...
}:
{
  imports = [
    (./. + "/${desktop}")

    ../dev
    ../scripts

    # ./alacritty.nix
    ./gaming.nix
    ./gtk.nix
    ./qt.nix
    ./rclone.nix
    ./xdg.nix
  ];

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

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = false;
      DisableTelemetry = true;
    };
  };

  fonts.fontconfig.enable = true;
}
