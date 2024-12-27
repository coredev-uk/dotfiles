{
  hostname,
  pkgs,
  lib,
  username,
  system,
  ...
}:
{
  imports = [
    ./boot.nix
    ./console.nix
    ./hardware.nix
    ./locale.nix
    ./nh.nix
    ./zramswap.nix
    ./nix-ld.nix

    ../services/openssh.nix
  ];

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  environment.systemPackages = (import ./packages.nix { inherit pkgs; }).basePackages;

  programs = {
    zsh.enable = true;
  };

  services = {
    chrony.enable = true;
    journald.extraConfig = "SystemMaxUse=250M";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Create dirs for home-manager
  systemd.tmpfiles.rules = [ "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root" ];
}
