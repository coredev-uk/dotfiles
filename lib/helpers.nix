{
  self,
  inputs,
  outputs,
  stateVersion,
  username,
  flakePath,
  ...
}:
{
  # Helper function for generating home-manager configs
  mkHome =
    {
      hostname,
      user ? username,
      desktop ? null,
      system ? "x86_64-linux",
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.unstable.legacyPackages.${system};
      extraSpecialArgs = {
        inherit
          self
          inputs
          outputs
          stateVersion
          hostname
          desktop
          flakePath
          ;
        username = user;
      };
      modules = [
        inputs.catppuccin.homeManagerModules.catppuccin
        ../home
      ];
    };

  # Helper function for generating host configs
  mkHost =
    {
      hostname,
      desktop ? null,
      pkgsInput ? inputs.unstable,
    }:
    pkgsInput.lib.nixosSystem {
      specialArgs = {
        inherit
          self
          inputs
          outputs
          stateVersion
          username
          hostname
          desktop
          flakePath
          ;
      };
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ../hosts
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}