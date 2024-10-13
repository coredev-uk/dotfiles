{ pkgs, ... }:
let
  inherit ((import ./file-associations.nix)) associations;
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
    portal = {
      # req: for gtk apps
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
