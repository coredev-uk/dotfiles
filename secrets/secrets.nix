let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFGD4CB9taNUU8tcWy/mbplg3wvpa3EDEjL7csfErkH";
  users = [
    paul
  ];

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k";
  systems = [
    hyperion
  ];
in
{
  "hyperion.age".publicKeys = [
    hyperion
    paul
  ];
}
