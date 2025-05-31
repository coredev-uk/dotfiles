{
  lib,
  outputs,
  stateVersion,
  username,
  inputs,
  type,
  hostname,
  homeDirectory,
  ...
}:
{
  imports =
    [
      ./common/shell
    ]
    ++ (lib.optional (type == "desktop") ./common/desktop)
    ++ (lib.optional (type == "darwin") ./hosts/${hostname}.nix);

  home = {
    inherit username stateVersion homeDirectory;
  };

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      inputs.agenix.overlays.default
    ];

    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # permittedInsecurePackages = [ "electron-25.9.0" ];
    };
  };
}
