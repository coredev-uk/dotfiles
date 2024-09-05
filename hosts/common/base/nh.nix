{ self, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    flake = "${self}";
    clean = {
      enable = true;
      extraArgs = "--keep-since 10d --keep 3";
    };
  };
}