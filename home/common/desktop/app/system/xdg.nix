{ pkgs, ... }:
let
  inherit ((import ./file-associations.nix)) associations;
in
{
  home.packages = with pkgs; [
    gnome-keyring
    gcr
    libsecret
    dconf
  ];

  services = {
    gnome-keyring.enable = true;
  };

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      # req: for gtk apps
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };
}
