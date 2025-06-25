{
  self,
  config,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/services/k3s.nix"
  ];

  age.secrets.hyperion.file = "${self}/secrets/hyperion.age";

  services.k3s.tokenFile = config.age.secrets.k3s.path;
  services.k3s.clusterInit = true;
  services.k3s.role = "server";

  time.timeZone = "Europe/London";

  networking = {
    hostName = "hyperion";

    useDHCP = false;

    defaultGateway.address = "10.147.20.1";

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
