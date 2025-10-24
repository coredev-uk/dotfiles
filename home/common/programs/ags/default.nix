{ inputs, pkgs, ... }:
{
  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages =
      let
        lib = inputs.ags.inputs.astal.packages.${pkgs.system};
      in
      with pkgs;
      [
        # Astal Libraries
        # @see https://aylur.github.io/astal/guide/libraries/references#astal-libraries
        lib.apps
        lib.mpris
        lib.tray
        lib.battery
        lib.powerprofiles
        lib.wireplumber
        lib.network

        # Standard
        fzf
      ];
  };
}
