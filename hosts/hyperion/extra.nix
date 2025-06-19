{
  inputs,
  pkgs,
  self,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"

    (import "${self}/hosts/common/services/nixidy.nix" {
      hostname = "hyperion";
      inherit inputs pkgs self;
    })
  ];

  time.timeZone = "Europe/London";

  networking = {
    hostName = "hyperion";

    interfaces.enp170s0 = {
      ipv4.addresses = [
        {
          address = "10.147.20.20";
          prefixLength = 24;
        }
      ];
      ipv4.routes = [
        {
          address = "0.0.0.0/0";
          via = "10.147.20.1";
        }
      ];
    };

    nameservers = [
      "8.8.8.8" # Google DNS
      "8.8.4.4" # Google DNS (secondary)
    ];
  };

}
