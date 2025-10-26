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

  services.cron.enable = true;

  networking = {
    hostName = "hyperion";

    useDHCP = false;

    defaultGateway.address = "192.168.20.1";

    interfaces.enp171s0 = {
      ipv4 = {
        addresses = [
          {
            address = "192.168.20.10";
            prefixLength = 24;
          }
        ];
      };
    };

    nameservers = [
      "8.8.8.8" # Google DNS
      "8.8.4.4" # Google DNS (secondary)
    ];
  };

  # Coral TPU configuration
  services.udev.extraRules = ''
    SUBSYSTEM=="apex", MODE="0660", GROUP="apex"
  '';

  users.groups.apex = { };

}
