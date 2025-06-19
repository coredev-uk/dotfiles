{ inputs, pkgs, ... }:
{

  # This declares the available nixidy envs.
  nixidyEnvs = inputs.nixidy.lib.mkEnvs {
    inherit pkgs;

    envs = {
      # Currently we only have the one dev env.
      dev.modules = [ ./env/dev.nix ];
    };
  };

  # Handy to have nixidy cli available in the local
  # flake too.
  packages.nixidy = nixidy.packages.${system}.default;

}
