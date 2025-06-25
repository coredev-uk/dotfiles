{
  pkgs,
  lib,
  modulesPath,
  meta,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../common/base
    ../common/users/${meta.username}
  ];

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  boot = {
    # Secure boot configuration
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"

        # For Nvidia
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
      ];

      systemd.dbus.enable = true;
    };

    # Nvidia
    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];

    kernelModules = [
      "kvm_amd"
      "vhost_vsock"
    ];

    # Use the Xanmod Kernel for gaming-related optimisations.
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}
