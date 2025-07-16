let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFGD4CB9taNUU8tcWy/mbplg3wvpa3EDEjL7csfErkH";

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k";
in
{
  "hyperion.age".publicKeys = [
    hyperion
    paul
  ];
}
