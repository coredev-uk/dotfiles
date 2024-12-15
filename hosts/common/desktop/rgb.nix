{ pkgs, ... }:
{
  # Enable OpenRGB
  services.hardware.openrgb.enable = true;

  # Enable I2C
  services.udev.packages = [ pkgs.openrgb ];
  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true;
}
