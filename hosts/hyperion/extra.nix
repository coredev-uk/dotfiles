{
  self,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/services/nixidy.nix"
    {
      hostname = "hyperion";
    }
  ];

  time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];
}
