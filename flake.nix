{
  description = "coredev-uk flake";

  inputs = {
    # NixOS Stable Base (NixOS systems follow this)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # New Dedicated Darwin Stable Base (nix-darwin will follow this)
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    # Bleeding-Edge Packages (Used for pkgs.unstable overlay)
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager"; # /release-25.05";
    home-manager.inputs.nixpkgs.follows = "unstable";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "unstable";

    ags.url = "github:/aylur/ags";
    ags.inputs.nixpkgs.follows = "unstable";

    catppuccin.url = "github:catppuccin/nix/release-25.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;

    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "unstable";

    nixcord.url = "github:kaylorben/nixcord";

    nvf.url = "github:notashelf/nvf";

    # TODO: Remove when https://github.com/NixOS/nixpkgs/pull/363992 is merged
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "unstable";
  };

  outputs =
    {
      self,
      unstable,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "25.05";
      username = "paul";

      libx = import ./lib {
        inherit
          self
          inputs
          outputs
          username
          stateVersion
          ;
      };
    in
    {
      # Home Manager configurations
      homeConfigurations = {
        "${username}@atlas" = libx.mkHome {
          hostname = "atlas";
          desktop = "hyprland"; # hyprland or i3
        };
        "${username}@hyperion" = libx.mkHome {
          hostname = "hyperion";
          type = "server";
          user = "${username}";
        };
      };

      # NixOS configurations
      nixosConfigurations = {
        atlas = libx.mkHost {
          hostname = "atlas";
          desktop = "hyprland"; # hyprland or i3
        };
        hyperion = libx.mkHost {
          hostname = "hyperion";
          type = "server";
        };
      };

      # Nix Darwin configurations
      darwinConfigurations = {
        poseidon = libx.mkDarwin {
          hostname = "poseidon";
        };
      };

      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = libx.forAllSystems (
        system:
        let
          pkgs = unstable.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs inputs; }
      );

      # Custom overlays
      overlays = import ./overlays { inherit inputs; };

      # Devshell for bootstrapping
      # Accessible via 'nix develop' or 'nix-shell' (legacy)
      devShells = libx.forAllSystems (
        system:
        let
          pkgs = unstable.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      formatter = libx.forAllSystems (system: self.packages.${system}.nixfmt-plus);
    };
}
