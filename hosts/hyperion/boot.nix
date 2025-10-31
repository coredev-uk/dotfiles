{
  config,
  meta,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../common/base
    ../common/users/${meta.username}
  ];

  boot = {
    # Enable Coral TPU support
    extraModulePackages = with config.boot.kernelPackages; [ gasket ];

    initrd = {
      availableKernelModules = [
        "nvme"
        "sd_mod"
        "sdhci_pci"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"
      "vhost_vsock"
      "gasket"
      "apex"
    ];

    kernel = {
      sysctl = {
        "fs.inotify.max_user_watches" = 524288;
      };
    };

    # Coral TPU PCIe compatibility parameters
    kernelParams = [
      "pcie_aspm=off" # Disable PCIe ASPM for TPU compatibility
    ];
  };
}
