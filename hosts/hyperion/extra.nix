{
  self,
  ...
}:
{
  age.secrets.hyperion.file = "${self}/secrets/hyperion.age";

  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/services/k3s.nix"
    "${self}/hosts/common/services/iscsi.nix"
  ];

  time.timeZone = "Europe/London";

  networking = {
    hostName = "hyperion";

    useDHCP = false;

    defaultGateway.address = "10.147.20.1";

    routes = [
      {
        address = "10.147.5.0";
        prefixLength = 24;
        via = "10.147.11.1";
      }
    ];

    interfaces.enp170s0 = {
      ipv4.addresses = [
        {
          address = "10.147.20.20";
          prefixLength = 24;
        }
      ];
    };

    nameservers = [
      "8.8.8.8" # Google DNS
      "8.8.4.4" # Google DNS (secondary)
    ];
  };

}
