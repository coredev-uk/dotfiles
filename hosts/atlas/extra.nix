{ self, desktop, ... }:
{
  imports =
    [
      "${self}/hosts/common/services/networkmanager.nix"
      "${self}/hosts/common/desktop/gaming.nix"
    ]
    + (if desktop == "i3" then [ ./display.nix ] else [ ]);

  # Fix the time when Dual-booting with Windows
  time.hardwareClockInLocalTime = true;
  # time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];

}
