{
  self,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
  ];

  time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];
}
