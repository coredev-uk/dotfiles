{
  lib,
  outputs,
  inputs,
  meta,
  ...
}:
{
  imports = [
    ./common/shell
  ]
  ++ lib.optional (!meta.isHeadless) ./common/dev
  ++ lib.optional meta.isDesktop ./common/desktop
  ++ lib.optional (builtins.pathExists (
    ./. + "/hosts/${meta.hostname}.nix"
  )) ./hosts/${meta.hostname}.nix;

  home = {
    inherit (meta) username;
    inherit (meta) homeDirectory;
    inherit (meta) stateVersion;
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
