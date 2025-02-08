{ pkgs, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };

  # nm-applet
  programs.nm-applet = {
    enable = true;
    indicator = false;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
