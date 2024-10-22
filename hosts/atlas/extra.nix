{ self, ... }:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
  ];

  # Fix the time when Dual-booting with Windows
  time.hardwareClockInLocalTime = true;
  # time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];
}
