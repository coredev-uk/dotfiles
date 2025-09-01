{ inputs, lib, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix { inherit lib; })
    ./longhorn.nix

    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
