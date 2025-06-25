{ pkgs, meta, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
  };

  environment.systemPackages = if meta.isDesktop then [ pkgs.blueberry ] else [ ];
}
