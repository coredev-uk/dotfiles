{
  inputs,
  pkgs,
  self,
  hostname,
  ...
}:
{

  # environment.systemPackages = with pkgs; [
  #   nixidy
  # ];

  _module.args.nixidyEnvs = inputs.nixidy.lib.mkEnvs {
    inherit pkgs;

    envs = {
      # Currently we only have the one dev env.
      dev.modules = [ "${self}/hosts/${hostname}/dev.nix" ];
    };
  };
}
