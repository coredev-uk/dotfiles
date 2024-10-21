{ self, ... }:
{
  imports = [ "${self}/hosts/common/services/networkmanager.nix" ];

  # Fix the time when Dual-booting with Windows
  time.hardwareClockInLocalTime = true;
  # time.timeZone = "Europe/London";
}
