{
  username,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../common/base
    ../common/users/${username}
  ];

  boot = {
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
      "vhost_vsock"
    ];
  };
}
