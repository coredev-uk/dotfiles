_: {

  systemd.services.systemd-vconsole-setup = {
    unitConfig = {
      After = "local-fs.target";
    };
  };

  boot = {
    initrd.systemd.enable = true;

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max"; # or auto
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
