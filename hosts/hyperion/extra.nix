{
  self,
  ...
}:
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/services/k3s.nix"
  ];

  # K3S Kubernetes
  services.k3s.role = "server";
  services.k3s.clusterInit = true;

  time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];
}
