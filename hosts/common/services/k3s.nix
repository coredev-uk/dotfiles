{
  meta,
  config,
  ...
}:
{

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
    role = "server";
    tokenFile = config.age.secrets.${meta.hostname}.path;
    extraFlags = toString (
      [
        "--write-kubeconfig-mode \"0644\""
        "--cluster-init"
        "--disable servicelb"
        "--disable traefik"
        "--disable local-storage"
      ]
      ++ (
        if meta.hostname == "hyperion" then
          [ ]
        else
          [
            "--server https://homelab-0:6443"
          ]
      )
    );
    clusterInit = (meta.hostname == "hyperion");
  };
}
