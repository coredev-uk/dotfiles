{
  self,
  inputs,
  outputs,
  stateVersion,
  username,
  flakePath,
  ...
}:
let
  mkHomeManager =
    { flakeInputs, flakeStateVersion }:
    {
      imports = [
        flakeInputs.catppuccin.homeModules.catppuccin
        flakeInputs.zen-browser.homeModules.twilight
        ../home # This path is relative to where this function is defined and used
      ];
      home.stateVersion = flakeStateVersion;
    };
in
{
  # Helper function for generating home-manager configs (nixos / linux configs)
  mkHome =
    {
      hostname,
      user ? username,
      desktop ? null,
      type ? "desktop",
      system ? "x86_64-linux",
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.unstable.legacyPackages.${system};
      extraSpecialArgs = {
        stable = inputs.nixpkgs.legacyPackages.${system};
        inherit
          self
          inputs
          outputs
          stateVersion
          hostname
          desktop
          flakePath
          type
          ;
        username = user;
        homeDirectory = "/home/${user}";
      };
      modules = [
        (mkHomeManager {
          flakeInputs = inputs;
          flakeStateVersion = stateVersion;
        })
      ];
    };

  # Helper function for generating host configs
  mkHost =
    {
      hostname,
      desktop ? null,
      type ? "desktop",
      pkgsInput ? inputs.unstable,
      system ? "x86_64-linux",
    }:
    pkgsInput.lib.nixosSystem {
      specialArgs = {
        stable = inputs.nixpkgs.legacyPackages.${system};
        inherit
          self
          inputs
          outputs
          stateVersion
          username
          hostname
          desktop
          flakePath
          system
          type
          ;
      };
      modules = [
        inputs.agenix.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote
        ../hosts
      ];
    };

  mkDarwin =
    {
      hostname,
      user ? username,
      system ? "aarch64-darwin",
      desktop ? "null",
      type ? "darwin",
    }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        flakePath = "/Users/${user}/.dotfiles";
        inherit
          self
          inputs
          outputs
          stateVersion
          username
          hostname
          desktop
          system
          type
          ;
      };
      modules = [
        ../hosts
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            #useGlobalPkgs = true;
            useUserPackages = true;
            users."${user}" = mkHomeManager {
              flakeInputs = inputs;
              flakeStateVersion = stateVersion;
            };
            extraSpecialArgs = {
              stable = inputs.nixpkgs.legacyPackages.${system};
              inherit
                self
                inputs
                outputs
                stateVersion
                hostname
                desktop
                type
                ;
              username = user;
              homeDirectory = "/Users/${user}";
              flakePath = "/Users/${user}/.dotfiles";
            };
          };
        }
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
