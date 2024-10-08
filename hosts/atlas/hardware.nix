{ inputs, lib, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix { inherit lib; })

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # ../common/hardware/bluetooth.nix
    # ../common/hardware/yubihsm.nix
  ];

  hardware.nvidia.open = false;

  #   hardware.amdgpu.amdvlk.enable = true;
  #   hardware.amdgpu.opencl.enable = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
