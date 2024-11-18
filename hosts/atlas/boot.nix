{ pkgs, lib, ... }:
{
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
      ];

      systemd.dbus.enable = true;
    };

    kernelModules = [
      "kvm_amd"
      "vhost_vsock"
    ];

    # Use the Xanmod Kernel for gaming-related optimisations.
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}
