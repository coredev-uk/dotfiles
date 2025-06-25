{
  lib,
  config,
  self,
  ...
}:
{
  age.secrets.k3s.file = "${self}/secrets/k3s.age";

  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];

  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent"; # or "server"
    tokenFile = config.age.secrets.k3s.path;
    extraFlags = toString [
      "--debug"
    ];
    # clusterInit = true;
    # serverAddr = "https://<ip of first node>:6443";
  };
}
