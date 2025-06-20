{
  self,
  inputs,
  outputs,
  stateVersion,
  username,
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
      flakePath ? "/home/${user}/.dotfiles",
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
      user ? username,
      desktop ? null,
      type ? "desktop",
      pkgsInput ? inputs.unstable,
      system ? "x86_64-linux",
      flakePath ? "/home/${user}/.dotfiles",
    }:
    pkgsInput.lib.nixosSystem {
      specialArgs = {
        stable = inputs.nixpkgs.legacyPackages.${system};
        username = user;
        inherit
          self
          inputs
          outputs
          stateVersion
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
      desktop ? null,
      type ? "darwin",
      flakePath ? "/Users/${user}/.dotfiles",
    }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
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
          flakePath
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
                flakePath
                ;
              username = user;
              homeDirectory = "/Users/${user}";
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
