let
  sysadmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKCmA4pOckYwJCeDUMOrRCU5xX2g1x9Ddsf3eDa4UViX";
  users = [
    sysadmin
  ];

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k";
  systems = [
    hyperion
  ];
in
{
  "hyperion.age".publicKeys = [
    hyperion
    sysadmin
  ];
}
