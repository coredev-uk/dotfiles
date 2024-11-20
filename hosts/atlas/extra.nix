{
  self,
  desktop,
  lib,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/desktop/gaming.nix"
  ] ++ lib.optional (desktop == "i3") ./display.nix;

  # Fix the time when Dual-booting with Windows
  time.hardwareClockInLocalTime = true;
  # time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];

}
