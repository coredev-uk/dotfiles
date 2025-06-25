{ pkgs, meta, ... }:
{
  environment.systemPackages = [ pkgs.nfs-utils ];
  services.openiscsi = {
    enable = true;
    name = "${meta.hostname}-initiatorhost";
  };
}
