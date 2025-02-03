{ pkgs, desktop, ... }:
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

  environment.systemPackages = if (builtins.isString desktop) then [ pkgs.blueberry ] else [ ];
}
