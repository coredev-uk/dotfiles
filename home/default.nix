{
  config,
  desktop,
  lib,
  outputs,
  stateVersion,
  username,
  inputs,
  ...
}:
{
  imports = [
    ./common/shell
  ] ++ lib.optional (builtins.isString desktop) ./common/desktop;

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
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
