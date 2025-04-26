{
  pkgs,
  ...
}:
{
  programs = {

    # Enable Steam
    steam = {
      enable = true;

      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

      # Protontricks
      protontricks = {
        enable = true;
      };

      # Proton-GE
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      package = pkgs.steam.override {
        extraPkgs = pkgs: [
          pkgs.corefonts # Microsoft Core Fonts
        ];
      };
    };

    # Enable GameMode
    gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "killall picom";
          end = "if not pgrep picom && not pgrep Hyprland; then exec picom; fi";
        };
      };
    };
  };

  # For Epic Games Store in Lutris
  hardware.graphics.enable32Bit = true;

  # Tweaks Required for Star-Citizen (src: https://github.com/starcitizen-lug/knowledge-base/wiki/Tips-and-Tricks#nixos)
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
}
